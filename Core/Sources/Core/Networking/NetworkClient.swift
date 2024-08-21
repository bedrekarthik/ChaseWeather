//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

/// Request information interface for outgoing request.
public struct NetworkClient {
    let url: String
    let queryParameters: [URLQueryItem]
    let httpMethod: HTTPMethod
    
    public init(
        url: String,
        queryParameters: [URLQueryItem],
        httpMethod: HTTPMethod = .get
    ) {
        self.url = url
        self.queryParameters = queryParameters
        self.httpMethod = httpMethod
    }
}

extension NetworkClient {
    
    /// Prepares the URL and relavent information before handover to HTTP Client.
    /// - Returns: Response.
    func execute<T: Decodable>() async throws -> NetworkResponse<T> {
        let request = try self.prepareRequest(url: url)
        let response = try await request.execute()
        let data: T = try response.data.toDecodable()
        return .init(data: data, urlResponse: response.urlResponse)
    }
}

extension NetworkClient {
    private func prepareRequest(url: String) throws -> NetworkRequestable {
        guard let relativeURL = URL(string: url) else { throw "Invalid url" }
        
        var urlcomponents = URLComponents()
        urlcomponents.queryItems = queryParameters
        guard let componentUrl = urlcomponents.url(relativeTo: relativeURL)
        else {
            throw "Invalid url components"
        }
        
        let networkRequest = NetworkRequest(url: componentUrl, httpMethod: httpMethod)
        return networkRequest
    }
}

extension Data {
    func toDecodable<T: Decodable>() throws -> T {
        try JSONDecoder()
            .decode(T.self, from: self)
    }
}

public enum HTTPMethod: String {
    case get = "GET"
}
