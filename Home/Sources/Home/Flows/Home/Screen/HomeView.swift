//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            CurrentLocationView(currentLocation: $viewModel.currentLocation)
            HourlyForecastView(currentLocation: $viewModel.currentLocation)
            DailyForecastView(currentLocation: $viewModel.currentLocation)
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}
