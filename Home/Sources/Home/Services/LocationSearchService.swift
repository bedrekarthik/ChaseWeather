//
//  File.swift
//
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Core

protocol LocationSearchServiceable {
    func fetchLocations(searchTerm: String) async throws -> [LocationModel]
}

struct LocationSearchService {
    struct Service: NetworkService {
        let networkClient: NetworkClient
    }
    
    private struct SearchLocationQuery {
        let searchTerm: String
        
        var asQueryParameters: [URLQueryItem] {
            [
                .apiKey(),
                .searchQuery(searchTerm),
                .limit()
            ]
        }
    }
}

extension LocationSearchService: LocationSearchServiceable {
    func fetchLocations(searchTerm: String) async throws -> [LocationModel] {
        let networkClient = NetworkClient(
            url: Configuration.Networking.WeatherEndpointHost.locationSearch,
            queryParameters: SearchLocationQuery(searchTerm: searchTerm).asQueryParameters
        )
        
        let service = Service(networkClient: networkClient)
        let response: NetworkResponse<[SearchLocationDTO]> = try await service.execute()
        
        let searchResults: [LocationModel] = response.data.map { LocationModel($0) }
        return searchResults
    }
}
