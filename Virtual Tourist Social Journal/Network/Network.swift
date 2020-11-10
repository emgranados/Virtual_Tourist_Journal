//
//  Network.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation

class Network {
     
    //MARK: Props
   
    var session = URLSession.shared
    
    // MARK: Shared Instance
    class func shared() -> Network {
        struct Singleton {
            static var shared = Network()
        }
        return Singleton.shared
    }
    //MARK: FlicrURL
   
    static func flickrURLFrom(parameters: [String: AnyObject]) -> URL{
        var components = URLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
    
            components.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        }
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: ",", with: "%2C")
        return components.url!
    }
}
