//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
@testable import Home

class MockCurrentLocationWeatherService: CurrentLocationWeatherServiceble {
    
    var failureResponse: Error?
    var didReceiveFetchRequest: Bool = false
    
    func fetchLocationWeather(_ currentLocation: LocationModel) async throws -> CurrentLocationWeatherModel {
        didReceiveFetchRequest = true
        if let failureResponse {
            throw failureResponse
        }
        return .mock
    }
}

extension CurrentLocationWeatherModel {
    static var mock: CurrentLocationWeatherModel {
        .init()
    }
}

extension NSError {
    static var asCurrentLocationFetchError: Error {
        return NSError(domain: "MockCurrentLocationWeatherService", code: -1, userInfo: [NSLocalizedDescriptionKey: "MockCurrentLocationWeatherService"])
    }
}
