//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
import Combine
import CoreLocation

public protocol DeviceLocationInformationProvider {
    var currentCoordinatePublisher: Published<CLLocation?>.Publisher { get }
    var currentAuthorizationStatusPublisher: Published<CLAuthorizationStatus?>.Publisher { get }
    var isAuthorized: Bool { get }
    var needsAuthorizationPermission: Bool { get }
    
    func requestForAuthorization()
}

public class LocationManager: NSObject, ObservableObject, DeviceLocationInformationProvider {
    
    @Published var authorizationStatus: CLAuthorizationStatus? = .notDetermined
    @Published var currentCoordinate: CLLocation?
    private var previousCoordinate: CLLocation = .init()
    private let locationManager = CLLocationManager()
    private var subscriptions: Set<AnyCancellable> = .init()
    
    public var currentAuthorizationStatusPublisher: Published<CLAuthorizationStatus?>.Publisher { $authorizationStatus }
    public var currentCoordinatePublisher: Published<CLLocation?>.Publisher { $currentCoordinate }
    
    public var isAuthorized: Bool {
        authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
    
    public var needsAuthorizationPermission: Bool {
        authorizationStatus == .notDetermined
    }
    
    override public init() {
        super.init()
        self.authorizationStatus = locationManager.authorizationStatus
        
        $currentCoordinate
            .compactMap { $0 }
            .sink { [weak self] location in
                if self?.previousCoordinate.coordinate != location.coordinate {
                    self?.previousCoordinate = location
                }
            }
            .store(in: &subscriptions)
    }
    
    public func requestForAuthorization() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if needsAuthorizationPermission {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            self.currentCoordinate = nil
        default:
            break
        }
        authorizationStatus = manager.authorizationStatus
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentCoordinate = location
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error("error: \(error.localizedDescription)")
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude.roundedDecimal == rhs.latitude.roundedDecimal && lhs.longitude.roundedDecimal == rhs.longitude.roundedDecimal
    }
}

extension CLLocationDegrees {
    var roundedDecimal: String {
        self.formatted(
            .number
                .precision(.significantDigits(4))
                .rounded(rule: .down)
        )
    }
}
