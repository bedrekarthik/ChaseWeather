//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Combine
import Core

class HourlyForecastViewModel: ObservableObject {
    @Published var hourlyForecasts: [ForecastModel] = []
    @Published var errorReceived: Error?
    
    private let service: HourlyForecastServiceble
    
    init(service: HourlyForecastServiceble = HourlyForecastService()) {
        self.service = service
    }
    
    func refreshData(for location: LocationModel) {
        Task { @MainActor in
            do {
                logger.info("Hourly forecast for: \(location.title)")
                let result: [ForecastModel] = try await service.fetchHourlyForecast(location)
                self.hourlyForecasts = result
            } catch {
                logger.error("\(error)")
                errorReceived = error
            }
        }
    }
}
