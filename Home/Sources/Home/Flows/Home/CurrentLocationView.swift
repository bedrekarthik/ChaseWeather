//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI

struct CurrentLocationView: View {
    
    @Binding var currentLocation: LocationModel?
    @ObservedObject var viewModel: CurrentLocationViewModel = .init()
    
    var body: some View {
        VStack(alignment: .center) {
            if let error = viewModel.errorReceived {
                ApiResponseErrorView(message: error.localizedDescription)
                    .padding([.bottom])
                    .foregroundColor(.white)
            } else {
                Text(viewModel.currentLocationWeather.name)
                    .modifier(LocationHeaderTitle())
                Spacer()
                Text(viewModel.currentLocationWeather.temperature)
                    .modifier(LocationHeaderTemperature())
                Spacer()
                Text(viewModel.currentLocationWeather.description)
                    .modifier(LocationHeaderStatus())
            }
        }
        .onChange(of: currentLocation) { oldValue, newValue in
            if let newValue {
                viewModel.refreshData(for: newValue)
            }
        }
    }
}
