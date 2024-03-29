//
//  CoffeePin.swift
//  FindIt
//
//  Created by Milos Malovic on 3.6.21..
//

import Foundation
import MapKit

class CoffeePin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?

    init(landmark: Landmark) {
        coordinate = landmark.coordinate
        title = landmark.name
        subtitle = landmark.phoneNumber
    }
}
