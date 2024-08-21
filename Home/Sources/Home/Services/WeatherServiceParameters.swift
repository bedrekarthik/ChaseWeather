//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Core

extension URLQueryItem {
    static func apiKey(_ key: String = Configuration.Networking.WeatherSubscription.apiKey) -> Self {
        .init(name: "appid", value: key)
    }
    
    static func searchQuery(_ query: String) -> Self {
        .init(name: "q", value: "\(query)")
    }
    
    static func latitude(_ lat: Double) -> Self {
        .init(name: "lat", value: "\(lat)")
    }
    
    static func longitude(_ long: Double) -> Self {
        .init(name: "lon", value: "\(long)")
    }
    
    static func unit(_ unit: String = "imperial") -> Self {
        .init(name: "units", value: "\(unit)")
    }
    
    static func limit(_ limit: String = Configuration.Networking.WeatherSubscription.searchResultLimit) -> Self {
        .init(name: "limit", value: "\(limit)")
    }
    
    static func count(_ count: String = "10") -> Self {
        .init(name: "cnt", value: "\(count)")
    }
}
