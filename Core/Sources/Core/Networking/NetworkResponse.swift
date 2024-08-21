//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation

public struct NetworkResponse<DataType> {
    public let data: DataType
    public let urlResponse: URLResponse
    
    init(data: DataType, urlResponse: URLResponse) {
        self.data = data
        self.urlResponse = urlResponse
    }
}
