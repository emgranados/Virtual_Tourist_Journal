//
//  Constants.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation


struct Constants {
    struct UserDefaults {
        struct Coordinate {
            static let latitude: String = "latitude"
            static let logitude: String = "logitude"
            static let latitudeDelta: String = "latitudeDelta"
            static let logitudeDelta: String = "logitudeDelta"
        }
        
        struct AppDelegate{
            static let hasAppLunchedBefore: String = "hasAppAlreadyLaunched"
        }
    }
     
    struct DataController {
        static let PersistantStoreName: String = "VirtualTourist"
    }
    
    struct DatabaseScheme {
        struct Place {
            static let latitude:  String = "latitude"
            static let longitude: String = "longitude"
            static let entityPlaceName: String = "place"
        }
        struct Image {
            static let url: String = "url"
            static let imageData: String = "imageData"
        }
    }
}
