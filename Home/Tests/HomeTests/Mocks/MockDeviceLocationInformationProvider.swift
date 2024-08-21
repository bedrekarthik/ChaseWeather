//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
import CoreLocation

@testable import Home
@testable import Core

class MockDeviceLocationInformationProvider: DeviceLocationInformationProvider {
    
    @Published var currentCoordinate: CLLocation?
    var currentCoordinatePublisher: Published<CLLocation?>.Publisher { $currentCoordinate }
    
    @Published var currentAuthorizationStatus: CLAuthorizationStatus?
    var currentAuthorizationStatusPublisher: Published<CLAuthorizationStatus?>.Publisher { $currentAuthorizationStatus }
    
    var isAuthorized: Bool { currentAuthorizationStatus == .authorizedAlways || currentAuthorizationStatus == .authorizedWhenInUse }
    var needsAuthorizationPermission: Bool { currentAuthorizationStatus == .notDetermined }
    
    var didCallRequestAuthorization: Bool = false
    func requestForAuthorization() {
        didCallRequestAuthorization = true
    }
}

extension CLLocation {
    static var mock: CLLocation {
        .init(latitude: 1.0, longitude: 2.0)
    }
}
