//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
@testable import Home

class MockHourlyForecastService: HourlyForecastServiceble {
    
    var failureResponse: Error?
    var didReceiveFetchRequest: Bool = false
    
    func fetchHourlyForecast(_ currentLocation: LocationModel) async throws -> [ForecastModel] {
        didReceiveFetchRequest = true
        if let failureResponse {
            throw failureResponse
        }
        return .mock
    }
}

extension NSError {
    static var asHourlyForecastFetchError: Error {
        return NSError(domain: "MockHourlyForecastService", code: -1, userInfo: [NSLocalizedDescriptionKey: "MockHourlyForecastService"])
    }
}
