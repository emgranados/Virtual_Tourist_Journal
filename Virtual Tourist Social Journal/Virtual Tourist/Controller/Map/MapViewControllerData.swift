//
//  MapViewControllerData.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import CoreData
import CoreLocation

extension MapViewController {
    func addNewPlace(with coordinate:CLLocationCoordinate2D, completionHandler:@escaping (_ objectID:NSManagedObjectID)->Void) {
        
        let backgroundContext = databaseManager.getBackgroundViewContext()
        let newPlace = Place(context: backgroundContext)
        newPlace.latitude  = coordinate.latitude
        newPlace.longitude = coordinate.longitude
        databaseManager.insert(object: newPlace){ objectID in
            completionHandler(objectID)
        }
    }
  //MARK: Places
    func loadAllPlaces() {
        places = [PutAnnotation]()
        
        guard let allSavedPlaces = databaseManager.getAll() as? [Place] else {
            return
        }
        
        for place in allSavedPlaces {
            let putAnnotation = PutAnnotation()
            putAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: place.latitude)!, longitude: CLLocationDegrees(exactly: place.longitude)!)
            putAnnotation.objectID = place.objectID
            places.append(putAnnotation)
        }
    }
    
    func getPlace(with objectID: NSManagedObjectID, completionHandler:@escaping (_ place:Place)->Void){
        databaseManager.getBy(objectID: objectID){ place in
            completionHandler(place as! Place)
        }
    }
}
 
extension MapViewController{
    func setupFetchResultController() {
        let fetchRequest:NSFetchRequest<Place> = Place.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: Constants.DatabaseScheme.Place.latitude, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        databaseManager = DatabaseManager(fetchRequest: fetchRequest as! NSFetchRequest<NSManagedObject>)
        databaseManager.fetchResultController.delegate = self
    }
}

extension MapViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
    
}
