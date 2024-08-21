//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/20/24.
//

import XCTest
import Combine

@testable import Home

final class HourlyForecastViewModelTests: XCTestCase {
    
    var service: MockHourlyForecastService!
    var viewModel: HourlyForecastViewModel!
    
    override func setUp() async throws {
        service = .init()
        viewModel = .init(service: service)
    }

    func test_refreshData_onSuccess() throws {
        // Prepare
        let expectation = expectation(description: "[ForecastModel] received")
        var receivedResponse: [ForecastModel]?
        let cancellable: AnyCancellable?
        cancellable = viewModel.$hourlyForecasts
            .dropFirst()
            .sink { forecasts in
                receivedResponse = forecasts
                expectation.fulfill()
            }
        
        // When
        viewModel.refreshData(for: .mock1)
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(receivedResponse, [ForecastModel].mock)
    }
    
    func test_refreshData_onFailure() throws {
        // Prepare
        let expectation = expectation(description: "[ForecastModel] fetch failure")
        var receivedError: Error?
        let cancellable: AnyCancellable?
        cancellable = viewModel.$errorReceived
            .dropFirst()
            .sink { error in
                receivedError = error
                expectation.fulfill()
            }
        
        // When
        let errorToSend: Error = NSError.asHourlyForecastFetchError
        service.failureResponse = errorToSend
        viewModel.refreshData(for: .mock1)
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(receivedError?.localizedDescription, errorToSend.localizedDescription)
    }
}

