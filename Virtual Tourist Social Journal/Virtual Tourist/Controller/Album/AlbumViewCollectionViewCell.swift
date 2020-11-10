//
//  AlbumViewCollectionViewCell.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit
import CoreData
import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
 
    //MARK: VARS
    var databaseManager: DatabaseManager!
    var image: Image!
 
    //MARK: Image
 
    func loadCellImage(completionHandler: @escaping(_ objectID: NSManagedObjectID?, _ imageData: Data?)->Void){
        if let imageData = image.imageData{
            self.imageView.image = UIImage(data: imageData)
            self.stopWaitingAnimation()
            completionHandler(nil, nil)
        }else {
            Network.loadImageFrom(url: image.url!){(success, imageData, error) in
                if success{
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData!)
                        self.stopWaitingAnimation()
                    }
                    self.databaseManager.save()
                    completionHandler(self.image.objectID, imageData)
                }
            }
        }
    }
    
    func showInvalidImage() {
        DispatchQueue.main.async {
            self.imageView.backgroundColor = UIColor.black
            self.stopWaitingAnimation()
        }
    }
    
    func startWaitingAnimation() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func stopWaitingAnimation() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}

