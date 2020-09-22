//
//  WeatherViewProperties.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-03.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation
import SwiftUI

struct WeatherViewProperties {
    static let bgColors = [
    "clear sky":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6544341662, green: 0.9271220419, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "few clouds":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5644291786, green: 0.6156922265, blue: 0.8125274491, alpha: 1)), Color(#colorLiteral(red: 0.3611070699, green: 0.3893437324, blue: 0.5149981027, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "scattered clouds":LinearGradient(gradient: Gradient(colors: [Color(hex: "bdc3c7"), Color(hex: "2c3e50")]), startPoint: .top, endPoint: .bottom),
    "overcast clouds":LinearGradient(gradient: Gradient(colors: [Color(hex: "bdc3c7"), Color(hex: "2c3e50")]), startPoint: .top, endPoint: .bottom),
    "broken clouds":LinearGradient(gradient: Gradient(colors: [Color(hex: "bdc3c7"), Color(hex: "2c3e50")]), startPoint: .top, endPoint: .bottom),
    "mist":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8536048541, green: 0.8154317929, blue: 0.6934956985, alpha: 1)), Color(#colorLiteral(red: 0.5, green: 0.3992742327, blue: 0.3267588525, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "thunderstorm":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "snow":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9551106616, green: 0.9764705896, blue: 0.9351792135, alpha: 1)), Color(#colorLiteral(red: 0.6891936611, green: 0.7095901305, blue: 0.9529411793, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "shower rain":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2854045624, green: 0.4267300284, blue: 0.6992385787, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "light rain":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2854045624, green: 0.4267300284, blue: 0.6992385787, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    "rain":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3437546921, green: 0.6157113381, blue: 0.7179171954, alpha: 1)), Color(#colorLiteral(red: 0.4118283819, green: 0.5814552154, blue: 0.6975531409, alpha: 1))]), startPoint: .top, endPoint: .bottom),
    ]
    
    static let icon = [
    "clear sky": "sun.min",
    "few clouds night": "cloud.moon",
    "few clouds": "cloud.sun",
    "broken clouds": "cloud",
    "scattered clouds": "cloud",
    "overcast clouds": "smoke",
    "mist": "cloud.drizzle",
    "thunderstorm": "cloud.bolt.rain",
    "snow": "wind.snow",
    "shower rain": "cloud.rain",
    "light rain": "cloud.drizzle",
    "rain": "cloud.heavyrain",
    ]
}

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
