//
//  MapViewControllerUpdate.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

extension MapViewController{
    func updateMapView(with region: MKCoordinateRegion){
        mapView.setRegion(region, animated: true)
    }
    
    func updateMapRegionInUserDefaults(){
        let region = mapView.region
        DispatchQueue.global(qos: .background).async{
            UserDefaults.standard.set(region.center.latitude, forKey: Constants.UserDefaults.Coordinate.latitude)
            UserDefaults.standard.set(region.center.longitude, forKey: Constants.UserDefaults.Coordinate.logitude)
            
            UserDefaults.standard.set(region.span.latitudeDelta, forKey: Constants.UserDefaults.Coordinate.latitudeDelta)
            UserDefaults.standard.set(region.span.longitudeDelta, forKey: Constants.UserDefaults.Coordinate.logitudeDelta)
        }
    }
}
 

