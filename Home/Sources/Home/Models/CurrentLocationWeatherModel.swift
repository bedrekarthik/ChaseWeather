//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

struct CurrentLocationWeatherModel {
    let name: String
    let temperature: String
    let description: String
    
    init(
        name: String = .default,
        temperature: String = .default,
        description: String = .default
    ) {
        self.name = name
        self.temperature = temperature
        self.description = description
    }
}

extension CurrentLocationWeatherModel {
    init(dto: CurrentLocationWeatherDTO) {
        self.name = dto.name.safeValue
        self.temperature = dto.main.temperature.asTemperatureString
        self.description = dto.weather.first?.status.safeValue ?? .default
    }
}

extension CurrentLocationWeatherModel: Identifiable, Equatable {
    var id: UUID { .init() }
}
