//
//  WeeklyWeatherRowView.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation

import SwiftUI

struct DailyWeatherRow: View {
  private let viewModel: DailyWeatherRowViewModel
  
  init(viewModel: DailyWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack {
        Image(systemName: "\(WeatherViewProperties.icon[viewModel.fullDescription] ?? "moon.stars.fill")").imageScale(.large)
        
      VStack {
        Text("\(viewModel.day)")
        Text("\(viewModel.month)")
      }
      
      VStack(alignment: .leading) {
        Text("\(viewModel.title)")
          .font(.body)
        Text("\(viewModel.fullDescription)")
          .font(.footnote)
      }
        .padding(.leading, 8)

      Spacer()

      Text("\(viewModel.temperature)°")
        .font(.title)
    }
  }
}
