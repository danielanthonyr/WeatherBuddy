//
//  WeeklyWeatherBuilder.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import SwiftUI

// Acts as factory to create screens that are needed when navigating from the WeeklyWeatherView
enum WeeklyWeatherBuilder {
    static func makeCurrentWeatherView(
        withCity city: String,
        weatherFetcher: WeatherFetchable
    ) -> some View {
        let viewModel = CurrentWeatherViewModel(city: city, weatherFetcher: weatherFetcher)
        return CurrentWeatherView(viewModel: viewModel)
    }
}
