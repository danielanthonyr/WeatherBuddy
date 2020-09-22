//
//  WeatherError.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//
import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
