//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Core

protocol DailyForecastServiceble {
    func fetchDailyForecast(_ currentLocation: LocationModel) async throws -> [ForecastModel]
}

struct DailyForecastService {
    struct Service: NetworkService {
        let networkClient: NetworkClient
    }
    
    struct DailyForecastQuery {
        let currentLocation: LocationModel
        
        var asQueryParameters: [URLQueryItem] {
            [
                .apiKey(),
                .latitude(currentLocation.latitude),
                .longitude(currentLocation.longitude),
                .unit(),
                .count("10")
            ]
        }
    }
}

extension DailyForecastService: DailyForecastServiceble {
    func fetchDailyForecast(_ currentLocation: LocationModel) async throws -> [ForecastModel] {
        let networkClient = NetworkClient(
            url: Configuration.Networking.WeatherEndpointHost.forecastDaily,
            queryParameters: DailyForecastQuery(currentLocation: currentLocation).asQueryParameters
        )
        
        let service = Service(networkClient: networkClient)
        let response: NetworkResponse<DailyForecastResponseDTO> = try await service.execute()
            
        let result: [ForecastModel] = response.data.forecast.map { .init($0) }
        return result
    }
}
