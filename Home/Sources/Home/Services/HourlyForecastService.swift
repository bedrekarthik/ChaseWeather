//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Core

protocol HourlyForecastServiceble {
    func fetchHourlyForecast(_ currentLocation: LocationModel) async throws -> [ForecastModel]
}

struct HourlyForecastService {
    struct Service: NetworkService {
        let networkClient: NetworkClient
    }
    
    struct HourlyForecastQuery {
        let currentLocation: LocationModel
        
        var asQueryParameters: [URLQueryItem] {
            [
                .apiKey(),
                .latitude(currentLocation.latitude),
                .longitude(currentLocation.longitude),
                .unit(),
                .count("24")
            ]
        }
    }
}

extension HourlyForecastService: HourlyForecastServiceble {
    func fetchHourlyForecast(_ currentLocation: LocationModel) async throws -> [ForecastModel] {
        let networkClient = NetworkClient(
            url: Configuration.Networking.WeatherEndpointHost.forecastHourly,
            queryParameters: HourlyForecastQuery(currentLocation: currentLocation).asQueryParameters
        )
        
        let service = Service(networkClient: networkClient)
        let response: NetworkResponse<HourlyForecastResponseDTO> = try await service.execute()
            
        let result: [ForecastModel] = response.data.forecast.map { .init($0) }
        return result
    }
}
