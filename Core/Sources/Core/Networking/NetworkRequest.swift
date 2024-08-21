//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

protocol NetworkRequestable {
    func execute() async throws -> NetworkResponse<Data>
}

/// HTTP Client to perform outdoing data task requests.
class NetworkRequest: NetworkRequestable {
    let urlSession: URLSession
    let url: URL
    let httpMethod: HTTPMethod
    
    init(
        urlSession: URLSession = .shared,
        url: URL,
        httpMethod: HTTPMethod
    ) {
        self.urlSession = urlSession
        self.url = url
        self.httpMethod = httpMethod
    }
    
    /// Finalizes the URLRequest and perform the Data Task Operation.
    /// - Returns: Response as with Data type.
    func execute() async throws -> NetworkResponse<Data> {
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10
        urlRequest.httpMethod = self.httpMethod.rawValue
        
        let (data, response) = try await urlSession.data(from: url)
        let status = (response as? HTTPURLResponse)?.statusCode
        guard let status, status == 200 else {
            let errorMessage = "Server responded with status code: \(status ?? -1)"
            throw NSError(domain: "NetworkRequest", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        
        return .init(data: data, urlResponse: response)
    }
}

extension String: Error {}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                       options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                  return nil
               }

        return prettyJSON
    }
}
