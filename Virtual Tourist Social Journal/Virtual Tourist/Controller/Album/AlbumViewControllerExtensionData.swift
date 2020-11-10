//
//  AlbumViewControllerExtensionData.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//


import Foundation
import CoreData

extension AlbumViewController{
    func saveSearchedAlbumFrom(urls: [URL]){
        for urlImage in urls{
            let image = Image(context: databaseManager.getBackgroundViewContext())
            image.url = urlImage
            image.imageData = nil
            image.place = self.place
        }
        databaseManager.save()
    }
    
    func deleteAllAlbumImagesFromDB(){
        databaseManager.deleteAllObjects()
    }
}

extension AlbumViewController{
    func setupFetchResultController() {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        let sortDescriptor = [NSSortDescriptor(key: Constants.DatabaseScheme.Image.imageData, ascending: false)]
        let predicate = NSPredicate(format: Constants.DatabaseScheme.Place.entityPlaceName.sqlExactlyEqual, place)
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = predicate
        databaseManager = DatabaseManager(fetchRequest: fetchRequest as! NSFetchRequest<NSManagedObject>)
        databaseManager.fetchResultController.delegate = self
    }
}

