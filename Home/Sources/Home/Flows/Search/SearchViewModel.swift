//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import Foundation
import Combine
import Core

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [LocationModel] = []
    @Published var errorReceived: Error?
    
    private let service: LocationSearchServiceable
    private var searchDebounceCancellable: AnyCancellable?
    
    init(service: LocationSearchServiceable = LocationSearchService()) {
        self.service = service
        self.subscribeForSearchText()
    }
    
    private func subscribeForSearchText() {
        searchDebounceCancellable = $searchText
            .dropFirst()
            .filter { _ in self.searchText.isEmpty == false }
            .throttle(for: .seconds(0.33), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] searchTerm in
                self?.performSearch(searchTerm)
            }
    }
    
    func performSearch(_ searchTerm: String) {
        Task { @MainActor in
            do {
                let results: [LocationModel] = try await service.fetchLocations(searchTerm: searchTerm)
                self.searchResults = results
            } catch {
                logger.error("\(error)")
                errorReceived = error
            }
        }
    }
}
