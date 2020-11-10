//
//  MapViewControllerUI.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit

extension MapViewController {
    
    func configureUI() {
        removePinText.isHidden = true
    }
    
    func enableUI(isEnabled: Bool) {
        removePinText.isEnabled = isEnabled
        information.isEnabled = isEnabled
    }
    func startWaitingIndicator() {
        enableUI(isEnabled: false)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopWaitingIndicator() {
        enableUI(isEnabled: true)
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
