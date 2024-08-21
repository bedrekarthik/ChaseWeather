//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

extension String {
    static let `default` = "--"
}

extension Optional<String> {
    var safeValue: String {
        self ?? .default
    }
}

extension String {
    func removingPrefixes(_ prefixes: [String]) -> String {
        let pattern = "^(\(prefixes.map{"\\Q"+$0+"\\E"}.joined(separator: "|")))\\s?"
        guard let range = self.range(of: pattern, options: [.regularExpression, .caseInsensitive]) else { return self }
        return String(self[range.upperBound...])
    }
}
