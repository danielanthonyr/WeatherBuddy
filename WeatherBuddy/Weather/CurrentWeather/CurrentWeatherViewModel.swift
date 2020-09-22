//
//  CurrentWeatherViewModel.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import SwiftUI
import Combine

// 1
class CurrentWeatherViewModel: ObservableObject, Identifiable {
  // 2
  @Published var dataSource: CurrentWeatherRowViewModel?
  
  let city: String
  // weatherFetcher = model
  private let weatherFetcher: WeatherFetchable
  private var disposables = Set<AnyCancellable>()
  
  init(city: String, weatherFetcher: WeatherFetchable) {
    self.weatherFetcher = weatherFetcher
    self.city = city
  }
  
  func refresh() {
    if city == "" {
        city
    }
    weatherFetcher
    .currentWeatherForecast(forCity: city)
    // 3
      .map(CurrentWeatherRowViewModel.init)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure:
          self.dataSource = nil
        case .finished:
          break
        }
        }, receiveValue: { [weak self] weather in
          guard let self = self else { return }
          self.dataSource = weather
      })
    .store(in: &disposables)
  }
}
