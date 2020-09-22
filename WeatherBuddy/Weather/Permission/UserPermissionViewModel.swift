//
//  UserPermissionViewModel.swift
//  WeatherBuddy
//
//  Created by Daniel Romero on 2020-06-26.
//  Copyright © 2020 Daniel Romero. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class UserPermissionViewModel: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }

    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension UserPermissionViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
}
