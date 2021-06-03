//
//  CoffeePinView.swift
//  FindIt
//
//  Created by Milos Malovic on 3.6.21..
//

import Foundation
import MapKit

class CoffeePinView: MKAnnotationView {

    override func layoutSubviews() {
        super.layoutSubviews()
        setupInitial()
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
    }

    override var annotation: MKAnnotation? {
        willSet {
            if let pin = newValue as? CoffeePin {
                clusteringIdentifier = "AnnotationViewIdentifier"
                pin.image = UIImage(named: "mappin.and.ellipse")
            }
        } didSet {
            clusteringIdentifier = "AnnotationViewIdentifier"
            self.image = UIImage(systemName: "mappin.and.ellipse")
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func call() {
        if let annotation = annotation as? CoffeePin {
            guard let phoneNumber = annotation.subtitle else { return }
            let nu = phoneNumber.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
            let num = "tel://" + nu
            if let url = URL(string: num) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }

    private func setupInitial() {
        let callButton = UIButton()
        callButton.imageView?.tintColor = .systemBlue
        callButton.setImage(UIImage(systemName: "phone.circle"), for: .normal)
        callButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        callButton.addTarget(self, action: #selector(call), for: .touchUpInside)
        rightCalloutAccessoryView = callButton
    }
}
