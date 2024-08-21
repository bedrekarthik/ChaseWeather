//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

/// Main Application Configurations.
///
/// This is likely to be auto generated file from build scripts
/// The values of these are to be managed by CICD variables.
public struct Configuration {
    public struct Networking {
        public struct WeatherSubscription {
            public static let apiKey: String = "e750ee86f62a0230e6991e42c166ea78"
            public static let searchResultLimit = "5"
        }
        
        public struct WeatherEndpointHost {
            public static let locationSearch = "https://api.openweathermap.org/geo/1.0/direct"
            public static let locationWeather = "https://api.openweathermap.org/data/2.5/weather"
            public static let forecastHourly = "https://pro.openweathermap.org/data/2.5/forecast/hourly"
            public static let forecastDaily = "https://pro.openweathermap.org/data/2.5/forecast/daily"
            public static let asset = "https://openweathermap.org/img/wn/"
        }
    }
}
