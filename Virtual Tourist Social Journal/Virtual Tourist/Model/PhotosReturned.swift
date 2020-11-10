//
//  PhotosReturned.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation


struct PhotosReturned: Decodable{
    let photos: Photos?
    let stat: String
    
    func isStatusOk() -> Bool{
        return stat == "ok"
    }
    
    func photosURLs() -> [URL] {
        var urls = [URL]()
        guard photos?.photo?.count ?? 0 > 0 else {
            return urls
        }
        
        for photo in (photos?.photo!)!{
            if let urlAsString = photo.url_s, let url = URL(string: urlAsString) {
                urls.append(url)
            }
        }
        
        return urls
    }
}

struct Photos: Decodable {
    let photo: [Photo]?
}

struct Photo: Decodable {
    let url_s: String?
}
