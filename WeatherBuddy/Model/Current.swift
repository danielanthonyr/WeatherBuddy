//
//  CurrentWeather.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-05-28.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

struct Current: Decodable {
    let observation_time : String?
    let temperature : Int?
    let weather_code : Int?
    let weather_icons : [String?]
    let weather_descriptions : [String?]
    let wind_speed : Int?
    let wind_degree : Int?
    let wind_dir : String?
    let pressure : Int?
    let precip : Double?
    let humidity : Int?
    let cloudcover : Int?
    let feelslike : Int?
    let uv_index : Int?
    let visibility : Int?
}
