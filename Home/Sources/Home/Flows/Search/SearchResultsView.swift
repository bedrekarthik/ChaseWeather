//
//  File.swift
//
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI

struct SearchResultsView: View {
    
    @Binding var currentLocation: LocationModel?
    @Environment(\.dismiss) var dismiss
        
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.searchResults) { location in
                Button {
                    if currentLocation != location {
                        currentLocation = location
                    }
                    dismiss()
                } label: {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text(location.title)
                                .font(.title2)
                            Text(location.subTitle)
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listStyle(.plain)        
    }
}
