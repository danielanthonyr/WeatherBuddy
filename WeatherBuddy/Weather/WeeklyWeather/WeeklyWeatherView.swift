//
//  WeeklyWeatherView.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

import SwiftUI

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    @State var weatherDescription = ""
    //@State var linearGradiant: LinearGradient
    
    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
//        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                WeatherViewProperties.bgColors[weatherDescription]
                    .edgesIgnoringSafeArea(.all)
                
                List{
                    searchField

                    if viewModel.dataSource.isEmpty {
                        emptySection
                    } else {
                        cityHourlyWeatherSection
                        forecastSection
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Weather 🌤")
            }
        }
    }
}

private extension WeeklyWeatherView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g. Montreal", text: $viewModel.city)
        }
    }
    
    var forecastSection: some View {
        Section {
            // Initializing daily weather row's with their own viewModels
            ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
        }
        .listRowBackground(WeatherViewProperties.bgColors[weatherDescription])
    }
    
    var cityHourlyWeatherSection: some View {
        Section {
            NavigationLink(destination: viewModel.currentWeatherView) {
                VStack(alignment: .leading) {
                    if viewModel.currentCity != "" {
                        Text(viewModel.currentCity)
                    } else {
                        Text(viewModel.city)
                    }
                    Text("Weather today")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
        }
    }
}
