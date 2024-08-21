//
//  File.swift
//
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI
import Core

struct HomeScreen: View {
    
    @State var showSearch: Bool = false
    @StateObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            HomeView(viewModel: viewModel)
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                .tint(.white)
            }
        }
        .onAppear {
            viewModel.load()
        }        
        .sheet(isPresented: $showSearch, content: {
            SearchScreen(currentLocation: $viewModel.currentLocation)
        })
    }
}
