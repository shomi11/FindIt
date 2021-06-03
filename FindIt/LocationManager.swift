//
//  LocationManager.swift
//  FindIt
//
//  Created by Milos Malovic on 2.6.21..
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var location: CLLocation?
    @Published var region: CLRegion?

    override init() {
        super.init()
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func requestLocation() {
        locationManager.requestLocation()
    }

    func updateLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error getting location \(error.localizedDescription)")
    }
}
