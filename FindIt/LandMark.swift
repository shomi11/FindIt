//
//  CoffeePin.swift
//  FindIt
//
//  Created by Milos Malovic on 3.6.21..
//

import Foundation
import MapKit

struct Landmark {

    let landMark: MKPlacemark
    let phoneNumber: String

    var id: UUID {
        return UUID()
    }

    var name: String {
        return landMark.name ?? ""
    }

    var subTitle: String {
        return landMark.subtitle ?? "s"
    }

    var coordinate: CLLocationCoordinate2D {
        return landMark.coordinate
    }
}
