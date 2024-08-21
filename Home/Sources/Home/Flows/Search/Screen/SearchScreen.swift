//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI

struct SearchScreen: View {
    
    @Binding var currentLocation: LocationModel?
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: SearchViewModel = .init()
    
    var body: some View {
        NavigationStack {
            SearchResultsView(currentLocation: $currentLocation, viewModel: viewModel)
                .searchable(text: $viewModel.searchText)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Search Location")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }                
        }
    }
}
