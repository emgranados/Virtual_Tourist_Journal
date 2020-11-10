//
//  Flickr.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation

extension Constants {
struct Flickr {

    //MARK: Static Declarations
    
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest/"
        static let APIBaseURL = "https://api.flickr.com/services/rest/"
        
        static let SearchBBoxHalfWidth = 1.0
        static let SearchBBoxHalfHeight = 1.0
        static let SearchLatRange = (-90.0, 90.0)
        static let SearchLonRange = (-180.0, 180.0)
 //MARK: API Key
        static let APIKey = "Your key goes here"
      
        struct FlickrParameterKeys {
            static let Method = "method"
            static let APIKey = "api_key"
            static let GalleryID = "gallery_id"
            static let Extras = "extras"
            static let Format = "format"
            static let Text = "text"
            static let SafeSearch = "safe_search"
            static let Bbox = "bbox"
            static let NoJSONCallback = "nojsoncallback"
            static let MaxPerPage = "per_page"
            static let PageNumber = "page"
        }
//MARK: Output
        struct OutputResponseFormat {
            struct Format {
                static let JSON = "json"
                static let XML = "XML"
            }
            
            struct JSONCallback {
                static let DisableJSONCallback = "1" /* 1 means "yes" */
                static let EnableJSONCallback  = "0"
            }
        }
        
        struct Methods {
            static let flickr_galleries_getPhotos = "flickr.galleries.getPhotos"
        }
   
        struct Photots {
            struct Methods {
                static let flickr_photos_search = "flickr.photos.search"
            }
        }
        
        struct Extras {
            static let url_m = "url_s"
        }
 
        struct SafeSearch {
            static let safe = "1"
            static let moderate = "2"
            static let restricted = "3"
        }
        
        struct CommonAttributes {
            static let title = "title"
        }
 //MARK: FLICKR Response
    
        struct FlickrResponseKeys {
            static let Status = "stat"
            static let Photos = "photos"
            static let Photo = "photo"
            static let Title = "title"
            static let MediumURL = "url_m"
            static let Pages = "pages"
        }
        
        struct Page {
            static let MaxPerPage = "20"
        }
        
        struct FlickrResponseValues {
            static let OKStatus = "ok"
        }
    }
}
 
