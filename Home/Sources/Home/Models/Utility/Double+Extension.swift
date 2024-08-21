//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

extension Optional<Double> {
    var asTemperatureString: String {
        guard let self else {
            return .default
        }
        // adding extra space at the begining to compensate for postfix space.
        return " " + String(Int(self)) + "°"
    }
}
