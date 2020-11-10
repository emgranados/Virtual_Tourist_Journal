//
//  MapViewControllerDelegates.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

extension MapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        updateMapRegionInUserDefaults()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? PutAnnotation {
            getPlace(with: annotation.objectID){ place in
                if self.isDeletingMode{
                    self.databaseManager.delete(object: place)
                    let index = self.places.firstIndex(of: annotation)
                    self.places.remove(at: index!)
                    self.mapView.removeAnnotation(annotation)
                } else {
                    self.openAlbumViewController(for: place)
                }
            }
        }
    }
}
