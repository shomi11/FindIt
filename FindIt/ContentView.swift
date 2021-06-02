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
    @State var searchText: String = ""

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 44.8125, longitude: 20.4612),
        span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
    )

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Find your place!")
        }
        .onReceive(locationManager.$location, perform: setMapRegion)
        .onReceive(locationManager.$authorizationStatus, perform: { status in
            switch status {
            case .authorizedAlways:
                locationManager.requestLocation()
            case .authorizedWhenInUse:
                locationManager.requestLocation()
            default:
                break
            }
        })
    }

    private func setMapRegion(with location: CLLocation?) {
        if let location = location {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

