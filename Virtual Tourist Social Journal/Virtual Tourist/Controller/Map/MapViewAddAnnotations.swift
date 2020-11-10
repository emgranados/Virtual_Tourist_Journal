//
//  MapViewAddAnnotations.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

extension MapViewController{
    
    func addAnnotationToDatabase(for coordinate:CLLocationCoordinate2D) {
        let annotation = PutAnnotation()
        annotation.coordinate = coordinate
        
        addNewPlace(with: coordinate) {
            objectID in
            annotation.objectID = objectID
            self.places.append(annotation)
            self.addAnnotationToMap(annotation)
        }
    }
    func addAnnotationToMap(_ annotation: PutAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
    func addAnnotationToMap(for annotation: PutAnnotation) {
        mapView.addAnnotation(annotation)
    }

    func showPinsOnMapForAllPlaces() {
        for place in places{
            addAnnotationToMap(for: place)
        }
    }
}
