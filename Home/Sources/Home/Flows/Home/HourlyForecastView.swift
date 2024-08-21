//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI
import Core

struct HourlyForecastView: View {
    
    @Binding var currentLocation: LocationModel?
    @ObservedObject var viewModel: HourlyForecastViewModel = .init()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("HOURLY FORECAST")
                    .font(.headline)
                Divider()
                    .background(.white)
            }
            .padding()
            if let error = viewModel.errorReceived {
                ApiResponseErrorView(message: error.localizedDescription)
                    .padding([.bottom])
            } else {
                HourlyForecastScrollView(forecasts: $viewModel.hourlyForecasts)
            }
        }
        .background {
            Color.blue.opacity(Tokens.Opacity.light300)
                .cornerRadius(Tokens.Spacing.padding20)
        }
        .foregroundStyle(.white)
        .padding()
        .onChange(of: currentLocation) { _, newValue in
            if let newValue {
                viewModel.refreshData(for: newValue)
            }
        }
    }
}

struct HourlyForecastScrollView: View {
    @Binding var forecasts: [ForecastModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Tokens.Spacing.padding24) {
                    ForEach(forecasts) { forecast in
                        HourlyForecastTileView(forecast: forecast)
                    }
                    
                }
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
}

struct HourlyForecastTileView: View {
    @State var forecast: ForecastModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(forecast.hour)
            Spacer(minLength: Tokens.Spacing.padding8)
            AsyncWeatherIconImage(url: forecast.temperatureIconUrl)
            Spacer(minLength: Tokens.Spacing.padding8)
            Text(forecast.currentTemperature)
        }
        .font(.title3)
        .fontWeight(.regular)
    }
}
