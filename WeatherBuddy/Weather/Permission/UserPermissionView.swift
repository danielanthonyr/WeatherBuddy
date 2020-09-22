//
//  UserPermissionView.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-26.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import SwiftUI

struct UserPermissionView: View {
    @ObservedObject var viewModel: UserPermissionViewModel
    
    init(viewModel: UserPermissionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            content
    }
    
    var content: AnyView {
        switch viewModel.authorisationStatus {
        case .notDetermined:
            return AnyView(requestPermissionView)
        case .denied:
            return AnyView(Text("Denied"))
        case .authorizedAlways, .authorizedWhenInUse:
            let fetcher = WeatherFetcher()
            let weeklyViewModel = WeeklyWeatherViewModel(weatherFetcher: fetcher)
            return AnyView(WeeklyWeatherView(viewModel: weeklyViewModel))
        default : return AnyView(Text("Default View"))
        }
    }
    
    var requestPermissionView: some View {
        ZStack {
            WeatherViewProperties.bgColors["clear sky"]
            .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    Image("weatherpermission")
                    Text("Hey! We need permission to access your location!")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title)
                    .frame(maxWidth: geometry.size.width * 0.80)
                    
                    Button(action: {
                        self.viewModel.requestAuthorisation()
                    }) {
                        Text("Grant Location")
                    }
                }
            }
        }
    }
}
