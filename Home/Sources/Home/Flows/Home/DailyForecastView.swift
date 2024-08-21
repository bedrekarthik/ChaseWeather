//
//  File.swift
//  
//
//  Created by KARTHIK BEDRE on 8/19/24.
//

import SwiftUI
import Core

struct DailyForecastView: View {
    
    @Binding var currentLocation: LocationModel?
    @ObservedObject var viewModel: DailyForecastViewModel = .init()
        
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("10-DAY FORECAST")
                        .font(.headline)
                    Spacer()
                }
            }
            .padding()
            
            if let error = viewModel.errorReceived {
                ApiResponseErrorView(message: error.localizedDescription)
                    .padding([.bottom])
            } else {
                DailyForecastListView(forecasts: $viewModel.dailyForecasts)
            }
        }
        .background {
            Color.blue.opacity(Tokens.Opacity.light300)
                .cornerRadius(Tokens.Spacing.padding20)
        }
        .foregroundStyle(.white)
        .padding()
        .onChange(of: currentLocation) { oldValue, newValue in
            if let newValue {
                viewModel.refreshData(for: newValue)
            }
        }
    }
}

struct DailyForecastListView: View {
    
    @Binding var forecasts: [ForecastModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: Tokens.Spacing.padding10) {
                    ForEach(forecasts) { forecast in
                        Divider()
                            .background(.white)
                        DailyForecastRowView(forecast: forecast)
                    }
                }
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
}

struct DailyForecastRowView: View {
    @State var forecast: ForecastModel
    
    var body: some View {
        HStack {
            HStack {
                Label(
                    title: { Text(forecast.day) },
                    icon: { EmptyView() }
                )
                .labelStyle(.titleOnly)
                .multilineTextAlignment(.leading)
                Spacer()
                AsyncWeatherIconImage(url: forecast.temperatureIconUrl)
            }
            .frame(width: Tokens.Size.size140)
            
            Spacer()
            
            HStack {
                Text("L:\(forecast.minimumTemperature)")
                    .foregroundStyle(.white.opacity(Tokens.Opacity.light700))
                Text("-")
                    .foregroundStyle(.white.opacity(Tokens.Opacity.light200))
                Text("H:\(forecast.maximumTemperature)")
            }
        }
        .font(.title2)
        .fontWeight(.semibold)
    }
}
