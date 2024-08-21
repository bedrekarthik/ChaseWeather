//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

extension Optional<TimeInterval> {
    var hour: String {
        guard let self else {
            return .default
        }
        let date = Date(timeIntervalSince1970: self)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh a"
        var hour = dayTimePeriodFormatter.string(from: date)
        hour = hour.replacingOccurrences(of: " ", with: "")
        hour = hour.removingPrefixes(["0"])
        return hour
    }
    
    var day: String {
        guard let self else {
            return .default
        }
        let date = Date(timeIntervalSince1970: self)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEE"
        return dayTimePeriodFormatter.string(from: date)
    }
}
