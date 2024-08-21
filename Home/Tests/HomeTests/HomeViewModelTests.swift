import XCTest
import Combine
import CoreLocation

@testable import Home

final class HomeViewModelTests: XCTestCase {
    
    var deviceLocationInformationProvider: MockDeviceLocationInformationProvider!
    var locationCacheManager: MockLocationCache!
    var homeViewModel: HomeViewModel!
    
    override func setUp() async throws {
        deviceLocationInformationProvider = .init()
        locationCacheManager = .init()
        homeViewModel = .init(locationCache: locationCacheManager, locationManager: deviceLocationInformationProvider)
    }
    
    func test_loadCurrentLocation_givenReturnedFromCache() throws {
        // Given
        locationCacheManager.mockedLocation = .mock1
        
        // When
        homeViewModel.load()
        
        // Then
        XCTAssertEqual(homeViewModel.currentLocation, locationCacheManager.mockedLocation)
        XCTAssertFalse(deviceLocationInformationProvider.didCallRequestAuthorization)
    }
    
    func test_requestAuthorization_givenCacheEmpty() throws {
        // Given, default state locationCacheManager lastLocation is nil.
        
        // When
        homeViewModel.load()
        
        // Then
        XCTAssertTrue(deviceLocationInformationProvider.didCallRequestAuthorization)
    }
    
    func test_loadLocation_givenLocationUpdates() throws {
        // Given, known last location
        locationCacheManager.mockedLocation = .mock1
        
        // Prepare
        let expectation = expectation(description: "LocationModel received")
        var expectedLocationModel: LocationModel?
        let cancellable: AnyCancellable?
        cancellable = homeViewModel.$currentLocation
            .dropFirst()
            .sink { locationModel in
                expectedLocationModel = locationModel
                expectation.fulfill()
            }
        
        // When
        deviceLocationInformationProvider.currentCoordinate = .mock
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(homeViewModel.currentLocation, expectedLocationModel)
        XCTAssertEqual(locationCacheManager.lastLocation(), expectedLocationModel)
    }
    
    func test_locationSelected_shouldSaveToCache() throws {
        // Prepare
        let expectation = expectation(description: "LocationModel saved")
        var receivedLocationModel: LocationModel?
        let cancellable: AnyCancellable?
        
        cancellable = homeViewModel.$currentLocation
            .dropFirst()
            .sink{ location in
                receivedLocationModel = location
                expectation.fulfill()
            }
        
        // When
        homeViewModel.currentLocation = .mock1
        
        wait(for: [expectation])
        cancellable?.cancel()
        
        // Then
        XCTAssertEqual(locationCacheManager.lastLocation(), receivedLocationModel)
    }
}
