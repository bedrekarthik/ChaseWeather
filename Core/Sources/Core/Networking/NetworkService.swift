//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

/// A interface which enables features to prepare a outgoing request.
public protocol NetworkService {
    /// Feature specific request information.
    var networkClient: NetworkClient { get }
}

extension NetworkService {
    
    /// Primary service execution handler for prepared NetworkClient information.
    /// - Returns: Response with specific T.
    public func execute<T: Decodable>() async throws -> NetworkResponse<T> {
        try await networkClient.execute()
    }
}
