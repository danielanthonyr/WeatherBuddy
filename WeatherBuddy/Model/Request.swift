//
//  Request.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-05-28.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

struct Request: Decodable {
    let type : String?
    let query : String?
    let language : String?
    let unit : String?
}
