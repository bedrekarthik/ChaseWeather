//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Combine
import Core

class CurrentLocationViewModel: ObservableObject {
    @Published var currentLocationWeather: CurrentLocationWeatherModel = .init()
    @Published var errorReceived: Error?
    
    private let service: CurrentLocationWeatherServiceble
    
    init(service: CurrentLocationWeatherServiceble = CurrentLocationWeatherService()) {
        self.service = service
    }
    
    func refreshData(for location: LocationModel) {
        Task { @MainActor in
            do {
                logger.info("Fetching location weather for: \(location.title)")
                let result: CurrentLocationWeatherModel = try await service.fetchLocationWeather(location)
                self.currentLocationWeather = result
            } catch {
                logger.error("\(error)")
                errorReceived = error
            }
        }
    }
}
