//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

struct CurrentLocationWeatherDTO: Decodable {
    let name: String?
    let main: WeatherMainDTO
    let weather: [WeatherCurrentDTO]
}
