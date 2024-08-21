//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

struct SearchLocationDTO: Decodable {
    let name: String
    let state: String?
    let country: String
    let lat: Double
    let lon: Double
}
