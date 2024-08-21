//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Core

protocol CurrentLocationWeatherServiceble {
    func fetchLocationWeather(_ currentLocation: LocationModel) async throws -> CurrentLocationWeatherModel
}

struct CurrentLocationWeatherService {
    struct Service: NetworkService {
        let networkClient: NetworkClient
    }
    
    struct CurrentLocationWeatherQuery {
        let currentLocation: LocationModel
        
        var asQueryParameters: [URLQueryItem] {
            [
                .apiKey(),
                .latitude(currentLocation.latitude),
                .longitude(currentLocation.longitude),
                .unit()
            ]
        }
    }
}

extension CurrentLocationWeatherService: CurrentLocationWeatherServiceble {
    func fetchLocationWeather(_ currentLocation: LocationModel) async throws -> CurrentLocationWeatherModel {
        let networkClient = NetworkClient(
            url: Configuration.Networking.WeatherEndpointHost.locationWeather,
            queryParameters: CurrentLocationWeatherQuery(currentLocation: currentLocation).asQueryParameters
        )
        
        let service = Service(networkClient: networkClient)
        let response: NetworkResponse<CurrentLocationWeatherDTO> = try await service.execute()
        
        let result: CurrentLocationWeatherModel = .init(dto: response.data)
        return result
    }
}
