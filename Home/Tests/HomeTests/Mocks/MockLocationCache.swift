//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
@testable import Home

class MockLocationCache: LocationCacheManaging {
    var mockedLocation: LocationModel?
    func saveLocation(_ location: LocationModel) {
        mockedLocation = location
    }
    
    func lastLocation() -> LocationModel? {
        mockedLocation
    }
}

extension LocationModel {
    static var mock1: Self {
        .init(title: .default, subTitle: .default, latitude: 1.0, longitude: 2.0)
    }
    
    static var mock2: Self {
        .init(title: .default, subTitle: .default, latitude: 2.0, longitude: 1.0)
    }
}
