//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

struct WeatherMainDTO: Decodable {
    let temperature: Double?
    let minimumTemperature: Double?
    let maximumTemperature: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }
}

struct WeatherTemperatureDTO: Decodable {
    let temperature: Double?
    let minimumTemperature: Double?
    let maximumTemperature: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "day"
        case minimumTemperature = "min"
        case maximumTemperature = "max"
    }
}

struct WeatherCurrentDTO: Decodable {
    let status: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "main"
        case icon
    }
}

struct HourlyForecastDTO: Decodable {
    let dt: TimeInterval?
    let main: WeatherMainDTO
    let weather: [WeatherCurrentDTO]
}

struct DailyForecastDTO: Decodable {
    let dt: TimeInterval?
    let temp: WeatherTemperatureDTO
    let weather: [WeatherCurrentDTO]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case weather
    }
}

struct HourlyForecastResponseDTO: Decodable {
    let forecast: [HourlyForecastDTO]
    
    enum CodingKeys: String, CodingKey {
        case forecast = "list"
    }
}

struct DailyForecastResponseDTO: Decodable {
    let forecast: [DailyForecastDTO]
    
    enum CodingKeys: String, CodingKey {
        case forecast = "list"
    }
}
