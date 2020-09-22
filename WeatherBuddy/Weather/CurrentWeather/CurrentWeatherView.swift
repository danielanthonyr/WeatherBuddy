//
//  CurrentWeatherView.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-08.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
        //UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        ZStack {
            WeatherViewProperties.bgColors[viewModel.dataSource?.fullDescription ?? "nil"]
            .edgesIgnoringSafeArea(.all)
            
            VStack(content: content)
            .onAppear(perform: viewModel.refresh)
            .navigationBarTitle(viewModel.city)
            .listStyle(GroupedListStyle())
        }
    }
}

private extension CurrentWeatherView {
    func content() -> some View {
        if let viewModel = viewModel.dataSource {
            return AnyView(details(for: viewModel))
        } else {
            return AnyView(loading)
        }
    }
    
    func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
        CurrentWeatherRow(viewModel: viewModel)
    }
    
    var loading: some View {
        Text("Loading \(viewModel.city)'s weather...")
    }
}
