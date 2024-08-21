//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation

protocol LocationCacheManaging {
    func saveLocation(_ location: LocationModel)
    func lastLocation() -> LocationModel?
}

struct LocationCache: LocationCacheManaging {
    let userDefaults: UserDefaults
    
    private let keyTitle: String = "cache.locationTitle"
    private let keySubTitle: String = "cache.locationSubTitle"
    private let keyLatitude: String = "cache.latitude"
    private let keyLongitude: String = "cache.longitude"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func saveLocation(_ location: LocationModel) {
        userDefaults.setValue(location.title, forKey: keyTitle)
        userDefaults.setValue(location.subTitle, forKey: keySubTitle)
        userDefaults.setValue(location.latitude, forKey: keyLatitude)
        userDefaults.setValue(location.longitude, forKey: keyLongitude)
    }
    
    func lastLocation() -> LocationModel? {
        guard let title = userDefaults.string(forKey: keyTitle),
              let subTitle = userDefaults.string(forKey: keySubTitle) else {
            return nil
        }
        
        let latitude = userDefaults.double(forKey: keyLatitude)
        let longitude = userDefaults.double(forKey: keyLongitude)
        
        return LocationModel(title: title, subTitle: subTitle, latitude: latitude, longitude: longitude)
    }
}
