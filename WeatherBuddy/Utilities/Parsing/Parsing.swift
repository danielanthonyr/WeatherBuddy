//
//  Parsing.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-07.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, WeatherError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
