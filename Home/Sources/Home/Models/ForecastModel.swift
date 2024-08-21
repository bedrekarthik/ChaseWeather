//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Core

struct ForecastModel {
    let hour: String
    let day: String
    let currentTemperature: String
    let minimumTemperature: String
    let maximumTemperature: String
    let temperatureIcon: String
    let temperatureStatus: String
}

extension ForecastModel {
    init(_ dto: HourlyForecastDTO) {
        self.hour = dto.dt.hour
        self.day = dto.dt.day
        self.currentTemperature = dto.main.temperature.asTemperatureString
        self.minimumTemperature = dto.main.minimumTemperature.asTemperatureString
        self.maximumTemperature = dto.main.maximumTemperature.asTemperatureString
        self.temperatureIcon = dto.weather.first?.icon ?? .default
        self.temperatureStatus = dto.weather.first?.status ?? .default
    }
    
    init(_ dto: DailyForecastDTO) {
        self.hour = dto.dt.hour
        self.day = dto.dt.day
        self.currentTemperature = dto.temp.temperature.asTemperatureString
        self.minimumTemperature = dto.temp.minimumTemperature.asTemperatureString
        self.maximumTemperature = dto.temp.maximumTemperature.asTemperatureString
        self.temperatureIcon = dto.weather.first?.icon ?? .default
        self.temperatureStatus = dto.weather.first?.status ?? .default
    }
}

extension ForecastModel: Identifiable, Equatable {
    var id: UUID { .init() }
}

extension ForecastModel {
    var temperatureIconUrl: URL? {
        URL(string: Configuration.Networking.WeatherEndpointHost.asset + temperatureIcon + "@2x.png")
    }
}
