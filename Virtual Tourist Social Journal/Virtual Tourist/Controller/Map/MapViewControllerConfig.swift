//
//  MapViewControllerConfig.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

extension MapViewController {

    func configureMapView() {
        mapView.delegate = self
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: UserDefaults.standard.float(forKey: Constants.UserDefaults.Coordinate.latitude))!, longitude: CLLocationDegrees(exactly: UserDefaults.standard.float(forKey: Constants.UserDefaults.Coordinate.logitude))!)
        let zoomSpan = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(exactly: UserDefaults.standard.float(forKey: Constants.UserDefaults.Coordinate.latitudeDelta))!, longitudeDelta: CLLocationDegrees(exactly: UserDefaults.standard.float(forKey: Constants.UserDefaults.Coordinate.logitudeDelta))!)
        let region = MKCoordinateRegion(center: coordinate, span: zoomSpan)
        updateMapView(with: region)
    }
}
 
