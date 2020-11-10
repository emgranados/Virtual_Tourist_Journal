//
//  AlbumViewControllerExtentionofUI.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit

extension AlbumViewController {
    func configureUI() {
        noImagesLbl.isHidden = true
    }
     
    func enableUI(isEnabled: Bool){
        DispatchQueue.main.async {
            self.newCollectionBtn.isEnabled = isEnabled
        }
    }
    
    func startWaitingIndicator() {
        DispatchQueue.main.async {
            self.enableUI(isEnabled: false)
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopWaitingIndicator() {
        DispatchQueue.main.async {
            self.enableUI(isEnabled: true)
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

