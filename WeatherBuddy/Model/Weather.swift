//
//  Weather.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-05-28.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation
import CoreLocation

// Weather struct encompasses all of our other models
// Weatherstack API Key : 3257c9ae2e331f5bfc88496b1b3a4e65
// URL : http://api.weatherstack.com/current?access_key=3257c9ae2e331f5bfc88496b1b3a4e65&query=45.3559827,-73.73180479999999

struct Weather: Decodable {
    let request: Request?
    let location: Location?
    let current: Current?
    
    init(request: Request?, location: Location?, current: Current?) {
        self.request = request
        self.location = location
        self.current = current
    }
}
