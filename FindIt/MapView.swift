//
//  MapView.swift
//  FindIt
//
//  Created by Milos Malovic on 3.6.21..
//

import Foundation
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {

    @Binding var userLocation: CLLocation?
    let landMarks: [Landmark]

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        map.register(CoffeePinView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if let region = centerUserInitial() {
            map.setRegion(region, animated: true)
        }
        return map
    }

    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(self)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotation(for: uiView)
    }

    func centerUserInitial() -> MKCoordinateRegion? {
        if let location = userLocation {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            return region
        }
        return nil
    }

    func updateAnnotation(for map: MKMapView) {
        map.removeAnnotations(map.annotations)
        let annotations = landMarks.map(CoffeePin.init)
        map.addAnnotations(annotations)
    }
}
