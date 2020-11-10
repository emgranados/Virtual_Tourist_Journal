//
//  AlbumViewControllerNetwork.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//


import Foundation

extension AlbumViewController {
    func loadAlbumImagesFromNetwork() {
        startWaitingIndicator()
        Network.getImages(for: place, at: currentPageNumber) { (success, urls, error) in
            if success {
                self.saveSearchedAlbumFrom(urls: urls!)
                self.stopWaitingIndicator()
            } else {
                print(error?.localizedDescription as Any)
            }
            self.stopWaitingIndicator()
        }
    }
}
