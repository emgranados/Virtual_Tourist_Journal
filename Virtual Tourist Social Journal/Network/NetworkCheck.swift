//
//  NetworkCheck.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import  UIKit

class NetworkCheck {

    public static func checkForDataResponse(functionName: String, data: Data?, response: URLResponse?, error: Error?) -> (Bool, NSError?){
        func sendError(error: String) -> (Bool, NSError?){
            let userInfo = [NSLocalizedDescriptionKey : error]
            return(false, NSError(domain: functionName, code: 1, userInfo: userInfo))
        }
  
        guard error == nil else{
            return sendError(error: "Error occurred while getting the data, error message: \(error!)")
        }

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            return sendError(error: "Your request returned a status code other than 2xx!")
        }

        guard data != nil else{
            return sendError(error: "Empty data is found!")
        }
        
        return (true, nil)
    }
}
