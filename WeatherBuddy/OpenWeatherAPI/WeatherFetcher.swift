//
//  WeatherFetcher.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation
import Combine

protocol WeatherFetchable {
    func weeklyWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
    
    func weeklyWeatherForecastWithLocation(
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
    
    func currentWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}

class WeatherFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

extension WeatherFetcher: WeatherFetchable {
  func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
    return forecast(with: makeWeeklyForecastComponents(withCity: city))
  }
    
    func weeklyWeatherForecastWithLocation(latitude: Double, longitude: Double) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        return forecast(with: makeWeeklyForecastComponentsWithLocation(latitude: latitude, longitude: longitude))
    }
  
  func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
    return forecast(with: makeCurrentDayForecastComponents(withCity: city))
  }
  
  private func forecast<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
    // Step 1
    guard let url = components.url else {
      let error = WeatherError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    
    // Step 2
    return session.dataTaskPublisher(for: URLRequest(url: url))
      
      // Step 3
      .mapError { error in
        .network(description: error.localizedDescription)
    }
      // Step 4
    .flatMap(maxPublishers: .max(1)) { pair in
      decode(pair.data)
    }
      // Step 5
  .eraseToAnyPublisher()
  }
}

// MARK: - OpenWeatherMap API
private extension WeatherFetcher {
  struct OpenWeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5"
    static let key = "4c2fbff26002295fc2990bc1e27de78f"
  }
  
  func makeWeeklyForecastComponents(
    withCity city: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenWeatherAPI.scheme
    components.host = OpenWeatherAPI.host
    components.path = OpenWeatherAPI.path + "/forecast"
    
    components.queryItems = [
      URLQueryItem(name: "q", value: city),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
    ]
    
    return components
  }
    
    func makeWeeklyForecastComponentsWithLocation(
        latitude: Double,
        longitude: Double
    ) -> URLComponents {
      var components = URLComponents()
      components.scheme = OpenWeatherAPI.scheme
      components.host = OpenWeatherAPI.host
      components.path = OpenWeatherAPI.path + "/forecast"
      
      components.queryItems = [
        URLQueryItem(name: "lat", value: latitude.description),
        URLQueryItem(name: "lon", value: longitude.description),
        URLQueryItem(name: "mode", value: "json"),
        URLQueryItem(name: "units", value: "metric"),
        URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
      ]
      
      return components
    }
  
  func makeCurrentDayForecastComponents(
    withCity city: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenWeatherAPI.scheme
    components.host = OpenWeatherAPI.host
    components.path = OpenWeatherAPI.path + "/weather"
    
    components.queryItems = [
      URLQueryItem(name: "q", value: city),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
    ]
    
    return components
  }
}
