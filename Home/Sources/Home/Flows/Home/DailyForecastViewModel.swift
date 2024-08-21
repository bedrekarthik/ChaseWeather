//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Combine
import Core

class DailyForecastViewModel: ObservableObject {
    @Published var dailyForecasts: [ForecastModel] = []
    @Published var errorReceived: Error?
    
    private let service: DailyForecastServiceble
    
    init(service: DailyForecastServiceble = DailyForecastService()) {
        self.service = service
    }
    
    func refreshData(for location: LocationModel) {
        Task { @MainActor in
            do {
                logger.info("Daily forecast for: \(location.title)")
                let result: [ForecastModel] = try await service.fetchDailyForecast(location)
                self.dailyForecasts = result
            } catch {
                logger.error("\(error)")
                errorReceived = error
            }
        }
    }
}

