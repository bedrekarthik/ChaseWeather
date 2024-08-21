//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Combine
import Core

class HomeViewModel: ObservableObject {
    @Published var currentLocation: LocationModel?
    @Published var locationPermissionDenied: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = .init()
    private let locationCache: LocationCacheManaging
    private let locationManager: DeviceLocationInformationProvider
    
    init(
        locationCache: LocationCacheManaging = LocationCache(),
        locationManager: DeviceLocationInformationProvider = LocationManager()
    ) {
        self.locationCache = locationCache
        self.locationManager = locationManager
        
        self.subscribeForLocationSelectionChange()
        self.subscribeForLocationChange()
    }
    
    func load() {
        if loadCachedLocation() == false {
            locationManager.requestForAuthorization()
        }
    }
    
    private func loadCachedLocation() -> Bool {
        if let cachedLocation = locationCache.lastLocation() {
            self.currentLocation = cachedLocation
            return true
        }
        return false
    }
    
    private func subscribeForLocationSelectionChange() {
        $currentLocation
            .sink { [weak self] newLocation in
                if let newLocation {
                    self?.locationCache.saveLocation(newLocation)
                }
            }
            .store(in: &subscriptions)
    }
    
    private func subscribeForLocationChange() {
        locationManager.currentCoordinatePublisher
            .dropFirst()
            .sink { [weak self] location in
                if let location {
                    let locationModel = LocationModel(
                        title: .default,
                        subTitle: .default,
                        latitude: location.coordinate.latitude,
                        longitude: location.coordinate.longitude
                    )
                    self?.locationCache.saveLocation(locationModel)
                    self?.currentLocation = locationModel
                }
            }
            .store(in: &subscriptions)
    }
}
