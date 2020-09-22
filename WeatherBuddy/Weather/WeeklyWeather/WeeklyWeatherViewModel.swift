//
//  WeeklyWeatherViewModel.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

// 1
class WeeklyWeatherViewModel: ObservableObject, Identifiable {
  // 2
  @Published var city: String = ""
    
  @Published var currentCity: String = ""
  
  //3
  @Published var dataSource: [DailyWeatherRowViewModel] = []
  
  // The model is Weather Fetcher
  private let weatherFetcher: WeatherFetchable
  
  // 4
  private var disposables = Set<AnyCancellable>()
  
  // 1 -> BRIDGING SWIFTUI & COMBINE
  init(
    weatherFetcher: WeatherFetchable,
    //scheduler parameter specifies which queue the HTTP request will use
    scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
  ) {
    self.weatherFetcher = weatherFetcher
    
    fetchWeatherWithLocation()
    
    // City is being observed
    $city
        // when observed city emits the first value, we don't want that in this case ""
        .dropFirst(1)
        // to prevent fetchweather from making an HTTP request everytime the user types 1 letter
        .debounce(for: .seconds(0.5), scheduler: scheduler)
        .sink(receiveValue: fetchWeather(forCity:))
        .store(in: &disposables)
  }
  
  func fetchWeather(forCity city: String) {
    // 1
    weatherFetcher.weeklyWeatherForecast(forCity: city)
    .map { response in
      // 2
      response.list.map(DailyWeatherRowViewModel.init)
    }
    
    // 3
      .map(Array.removeDuplicates)
    
    // 4
      .receive(on: DispatchQueue.main)
    
    // 5
      .sink(receiveCompletion: { [weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure:
          // 6
          self.dataSource = []
        case .finished:
          break
        }
        }, receiveValue: {[weak self] forecast in
          guard let self = self else { return }
          
          // 7
          self.dataSource = forecast
            self.currentCity = ""
      })
    
      // 8
    .store(in: &disposables)
  }
    
    func fetchWeatherWithLocation() {
        var locManager = CLLocationManager()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            
            // To get user's current city once he enters the app and accepts location access
            CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, _) -> Void in
                placemarks?.forEach { (placemark) in
                    if let city = placemark.locality {
                        self.currentCity = city
                    }
                }
            })
            
            // 1
            weatherFetcher.weeklyWeatherForecastWithLocation(latitude: latitude, longitude: longitude)
            .map { response in
              // 2
              response.list.map(DailyWeatherRowViewModel.init)
            }
            
            // 3
              .map(Array.removeDuplicates)
            
            // 4
              .receive(on: DispatchQueue.main)
            
            // 5
              .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  // 6
                  self.dataSource = []
                case .finished:
                  break
                }
                }, receiveValue: {[weak self] forecast in
                  guard let self = self else { return }
                  
                  // 7
                  self.dataSource = forecast
              })
            
              // 8
            .store(in: &disposables)
        }
    }
}

extension WeeklyWeatherViewModel {
    var currentWeatherView: some View {
        if city == "" {
            return WeeklyWeatherBuilder.makeCurrentWeatherView(withCity: currentCity, weatherFetcher: weatherFetcher)
        }
        return WeeklyWeatherBuilder.makeCurrentWeatherView(withCity: city, weatherFetcher: weatherFetcher)
    }
    
    
}
