//
//  ContentView.swift
//  FindIt
//
//  Created by Milos Malovic on 2.6.21..
//

import SwiftUI
import MapKit

struct ContentView: View {

    @ObservedObject var locationManager = LocationManager()
    @State private var searchText: String = ""
    @State private var location: CLLocation?
    @State private var landmarks: [Landmark] = []

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                MapView(userLocation: $location, landMarks: landmarks)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Find your place!")
        }
        .onChange(of: searchText, perform: { value in
            getLocalCoffee()
        })
        .onReceive(locationManager.$location, perform: userLocation)
        .onReceive(locationManager.$authorizationStatus, perform: { status in
            switch status {
            case .authorizedAlways:
                locationManager.updateLocation()
            case .authorizedWhenInUse:
                locationManager.updateLocation()
            default:
                break
            }
        })
    }

    private func userLocation(location: CLLocation?) {
        self.location = location
        locationManager.stopUpdatingLocation()
    }

    /// Show only local coffee shops
    private func getLocalCoffee() {
        let request = MKLocalSearch.Request()
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.cafe])
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        search.start { response, err in
            guard err == nil else { return }
            guard let response = response else { return }
            let items = response.mapItems
            landmarks = items.map {
                Landmark(landMark: $0.placemark, phoneNumber: $0.phoneNumber ?? "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

