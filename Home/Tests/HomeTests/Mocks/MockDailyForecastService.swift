//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
@testable import Home

class MockDailyForecastService: DailyForecastServiceble {
    
    var failureResponse: Error?
    var didReceiveFetchRequest: Bool = false
    
    func fetchDailyForecast(_ currentLocation: LocationModel) async throws -> [ForecastModel] {
        didReceiveFetchRequest = true
        if let failureResponse {
            throw failureResponse
        }
        return .mock
    }
}

extension [ForecastModel] {
    static var mock: [ForecastModel] {
        [
            .init(
                hour: .default,
                day: .default,
                currentTemperature: .default,
                minimumTemperature: .default,
                maximumTemperature: .default,
                temperatureIcon: .default,
                temperatureStatus: .default
            )
        ]
    }
}

extension NSError {
    static var asDailyForecastFetchError: Error {
        return NSError(domain: "MockDailyForecastService", code: -1, userInfo: [NSLocalizedDescriptionKey: "MockDailyForecastService"])
    }
}
