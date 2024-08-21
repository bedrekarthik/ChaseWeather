//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import XCTest
import Combine

@testable import Home

final class CurrentLocationViewModelTests: XCTestCase {
    
    var service: MockCurrentLocationWeatherService!
    var viewModel: CurrentLocationViewModel!
    
    override func setUp() async throws {
        service = .init()
        viewModel = .init(service: service)
    }

    func test_refreshData_onSuccess() throws {
        // Prepare
        let expectation = expectation(description: "CurrentLocationWeatherModel received")
        var receivedResponse: CurrentLocationWeatherModel?
        let cancellable: AnyCancellable?
        cancellable = viewModel.$currentLocationWeather
            .dropFirst()
            .sink { locationModel in
                receivedResponse = locationModel
                expectation.fulfill()
            }
        
        // When
        viewModel.refreshData(for: .mock1)
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(receivedResponse, CurrentLocationWeatherModel.mock)
    }
    
    func test_refreshData_onFailure() throws {
        // Prepare
        let expectation = expectation(description: "CurrentLocationWeatherModel fetch failure")
        var receivedError: Error?
        let cancellable: AnyCancellable?
        cancellable = viewModel.$errorReceived
            .dropFirst()
            .sink { error in
                receivedError = error
                expectation.fulfill()
            }
        
        // When
        let errorToSend: Error = NSError.asCurrentLocationFetchError
        service.failureResponse = errorToSend
        viewModel.refreshData(for: .mock1)
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(receivedError?.localizedDescription, errorToSend.localizedDescription)
    }
}
