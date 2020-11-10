//
//  NetworkExtension.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//


import CoreLocation
import Foundation
import UIKit

extension Network {
    
 //MARK: GETDATA
    private static func getData(url: URL, completionHandler: @escaping(_ success:Bool, _ data: Data?, _ error: NSError?) -> Void){
        let request = URLRequest(url: url)
        let task = self.shared().session.dataTask(with: request){
            (data, response, error) in
            let (success, error) = NetworkCheck.checkForDataResponse(functionName: "getData", data: data, response: response, error: error)
            if success {
                completionHandler(true, data!, nil)
            } else {
                completionHandler(false, nil, error)
            }
        }
        task.resume()
    }
//MARK: GETIMAGES
    
    static func getImages(for place: Place, at pageNumber: Int, completionHandler: @escaping (_ success:Bool, _ images: [URL]?, _ error: NSError?)->Void){
        let searchPhotosURL = flickrURLFrom(parameters: getFlickrParameters(for: place, at: pageNumber))
        getImages(from: searchPhotosURL){ success, images, error in
            completionHandler(success, images, error)
        }
    }
    private static func getImages(from url: URL, completionHandler: @escaping (_ success:Bool, _ images: [URL]?, _ error: NSError?)->Void){
        self.getData(url: url){ (success, data, error) in
            if success{
                do{
                    let photosReturned = try JSONDecoder().decode(PhotosReturned.self, from: data!)
                    completionHandler(true, photosReturned.photosURLs(), nil)
                }catch let error{
                    completionHandler(false, nil, error as NSError)
                }
            }else {
                completionHandler(false, nil, error)
            }
        }
    }
//MARK: Location settings and parameters
    
    private static func bboxString(latitude: Double, longitude: Double) -> String {
        // ensure bbox is bounded by minimum and maximums
        let minimumLon = max(longitude - Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.0)
        let minimumLat = max(latitude - Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.0)
        let maximumLon = min(longitude + Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.1)
        let maximumLat = min(latitude + Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.1)
        return "\(minimumLon),\(minimumLat),\(maximumLon),\(maximumLat)"
    }
    
    private static func getFlickrParameters(for place: Place, at pageNumber: Int) -> [String: AnyObject]{
        
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: place.latitude)!, longitude: CLLocationDegrees(exactly: place.longitude)!)
        
        let flickrParameters =
            [
                Constants.Flickr.FlickrParameterKeys.Method : Constants.Flickr.Photots.Methods.flickr_photos_search as AnyObject,
                Constants.Flickr.FlickrParameterKeys.APIKey : Constants.Flickr.APIKey as AnyObject,
                Constants.Flickr.FlickrParameterKeys.Bbox : bboxString(latitude: coordinate.latitude, longitude: coordinate.longitude),
                Constants.Flickr.FlickrParameterKeys.MaxPerPage: Constants.Flickr.Page.MaxPerPage,
                Constants.Flickr.FlickrParameterKeys.PageNumber: "\(pageNumber)",
                Constants.Flickr.FlickrParameterKeys.SafeSearch : Constants.Flickr.SafeSearch.safe,
                Constants.Flickr.FlickrParameterKeys.Extras : Constants.Flickr.Extras.url_m,
                Constants.Flickr.FlickrParameterKeys.Format : Constants.Flickr.OutputResponseFormat.Format.JSON,
                Constants.Flickr.FlickrParameterKeys.NoJSONCallback : Constants.Flickr.OutputResponseFormat.JSONCallback.DisableJSONCallback
                ] as [String: AnyObject]
        
        return flickrParameters
    }
    
    static func loadImageFrom(url: URL, completionHandler: @escaping(_ success : Bool, _ imageData : Data?, _ error : NSError?)->Void){
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, urlResponse, error) in
            
            let (success, error) = NetworkCheck.checkForDataResponse(functionName: "loadImageFrom", data: data, response: urlResponse, error: error)
            
            if success{
                completionHandler(true, data!, nil)
            }else {
                completionHandler(false, nil, error)
            }
        })
        task.resume()
    }
    
    func loadImageFrom(data: Data){
        
    }
}

