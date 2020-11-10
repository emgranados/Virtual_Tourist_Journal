//
//  AlbumViewControllerData.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit
import CoreData

extension AlbumViewController: UICollectionViewDataSource {

  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionInfo = databaseManager.fetchResultController.sections?[section] {
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AlbumCollectionViewCell
        cell.imageView.image = nil
        cell.startWaitingAnimation()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image = self.databaseManager.getObject(at: indexPath) as! Image
        let imageCell = cell as! AlbumCollectionViewCell
        imageCell.image = image
        
        configImage(using: imageCell, photo: image, collectionView: collectionView, index: indexPath)
    }
    
    

    private func configImage(using cell: AlbumCollectionViewCell, photo: Image, collectionView: UICollectionView, index: IndexPath) {
        if let imageData = photo.imageData {
            cell.stopWaitingAnimation()
            cell.imageView.image = UIImage(data: imageData)
        } else {
            if let imageUrl = photo.url {
                cell.activityIndicator.startAnimating()
                Network.loadImageFrom(url: imageUrl){ (success, data, error) in
                    if success {
                        DispatchQueue.main.async {
                            if let currentCell = collectionView.cellForItem(at: index) as? AlbumCollectionViewCell {
                                if currentCell.image.url == imageUrl {
                                    currentCell.imageView.image = UIImage(data: data!)
                                    cell.stopWaitingAnimation()
                                }
                            }
                            photo.imageData = data!
                            DispatchQueue.global(qos: .background).async {
                                self.databaseManager.save()
                            }
                        }
                    }
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewContext = self.databaseManager
        let photoToDelete = databaseManager.fetchResultController.object(at:indexPath)
        viewContext?.delete(object: photoToDelete)
 
    }
}
