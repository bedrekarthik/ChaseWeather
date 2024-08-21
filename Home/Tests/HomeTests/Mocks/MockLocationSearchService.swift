//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import Foundation
@testable import Home

class MockLocationSearchService: LocationSearchServiceable {
    
    var failureResponse: Error?
    var didReceiveFetchRequest: Bool = false
    var searchTerm: String? = nil
    
    func fetchLocations(searchTerm: String) async throws -> [LocationModel] {
        self.searchTerm = searchTerm
        self.didReceiveFetchRequest = true
        if let failureResponse {
            throw failureResponse
        }
        return .mock
    }
}

extension [LocationModel] {
    static var mock: [LocationModel] {
        .init()
    }
}

extension NSError {
    static var asLocationSearchFetchError: Error {
        return NSError(domain: "MockLocationSearchService", code: -1, userInfo: [NSLocalizedDescriptionKey: "MockLocationSearchService"])
    }
}
