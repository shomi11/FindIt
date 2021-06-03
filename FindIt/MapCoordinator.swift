//
//  MapCoordinator.swift
//  FindIt
//
//  Created by Milos Malovic on 3.6.21..
//

import Foundation
import MapKit
import SwiftUI

class MapCoordinator: NSObject, MKMapViewDelegate {

    var mapControl: MapView

    init(_ map: MapView) {
        mapControl = map
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !view.isKind(of: MKUserLocation.self) else { return }
        if let annotation = view.annotation {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude), latitudinalMeters: 400, longitudinalMeters: 400)
            mapView.setRegion(region, animated: true)
        }
    }
}
