//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import XCTest
import Combine

@testable import Home

final class SearchViewModelTests: XCTestCase {
    
    var service: MockLocationSearchService!
    var viewModel: SearchViewModel!
    
    override func setUp() async throws {
        service = .init()
        viewModel = .init(service: service)
    }

    func test_performSearch_onSearchTermChange() throws {
        // Prepare
        let expectation = expectation(description: "Searchterm received")
        var receivedResponse: [LocationModel]?
        let cancellable: AnyCancellable?
        cancellable = viewModel.$searchResults
            .dropFirst()
            .sink { locations in
                receivedResponse = locations
                expectation.fulfill()
            }
        
        // When
        let searchTerm = "test"
        viewModel.performSearch(searchTerm)
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(receivedResponse, .mock)
        XCTAssertEqual(service.searchTerm, searchTerm)
    }
    
    func test_refreshData_onFailure() throws {
        // Prepare
        let expectation = expectation(description: "[LocationModel] fetch failure")
        var receivedError: Error?
        let cancellable: AnyCancellable?
        cancellable = viewModel.$errorReceived
            .dropFirst()
            .sink { error in
                receivedError = error
                expectation.fulfill()
            }
        
        // When
        let errorToSend: Error = NSError.asLocationSearchFetchError
        service.failureResponse = errorToSend
        
        let searchTerm = "test"
        viewModel.performSearch(searchTerm)
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(receivedError?.localizedDescription, errorToSend.localizedDescription)
    }
}

