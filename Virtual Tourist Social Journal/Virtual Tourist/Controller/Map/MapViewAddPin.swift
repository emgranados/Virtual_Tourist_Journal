//
//  MapViewAddPin.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension MapViewController {
    
    func addMapGestures() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addPinToMap))
        mapView.addGestureRecognizer(longPressGestureRecognizer)
    }

    @objc func addPinToMap(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
                let locationInView = sender.location(in: mapView)
                let tappedCoordinate = mapView.convert(locationInView , toCoordinateFrom: mapView)
                addAnnotationToDatabase(for: tappedCoordinate)
        }
    }
}
