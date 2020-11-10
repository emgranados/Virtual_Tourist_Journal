//
//  DatabaseManager.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import CoreData
 
class DatabaseManager {
    static var dataController: DataController!
    var fetchResultController: NSFetchedResultsController<NSManagedObject>!
    
    init(fetchRequest:NSFetchRequest<NSManagedObject>) {
 
        self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.getViewContext(), sectionNameKeyPath: nil, cacheName: nil)
        setupFetchResultController()
    }
}

extension DatabaseManager: DatabaseRepositoryProtocol{
 
//MARK: Get functions
    
    func getAll() -> [NSManagedObject]? {
        guard let allObjects = fetchResultController?.fetchedObjects else {
            return nil
        }
        return allObjects
    }
    
    func getBy(objectID: NSManagedObjectID, completionHandler:@escaping (_ object:NSManagedObject)->Void) {
        let viewContext = self.getBackgroundViewContext()
        viewContext.performAndWait {
            let searchObject = viewContext.object(with: objectID)
            completionHandler(searchObject)
        }
    }
    
    func getObject(at indexPath: IndexPath) -> NSManagedObject{
        return fetchResultController.object(at: indexPath)
    }
  
    //MARK: OBJECT Functions
    
    func insert(object: NSManagedObject, completionHandler: @escaping(_ objectID: NSManagedObjectID)->Void) {
        self.getBackgroundViewContext().performAndWait {
            self.save()
            completionHandler(object.objectID)
        }
    }
        
    func update(object: NSManagedObject) {
  
    }
    
    func delete(object: NSManagedObject){
        self.getViewContext().delete(object)
        self.save()
    }
    
    func deleteObject(at indexPath: IndexPath){
        let objectToDelete = fetchResultController.object(at: indexPath)
        self.getViewContext().delete(objectToDelete)
        self.save()
    }
    
    func deleteAllObjects() {
        guard let objects = fetchResultController?.fetchedObjects else {
            return
        }
        for object in objects{
            getViewContext().delete(object)
        }
        self.save()
    }
    
    func save() {
        getViewContext().performAndWait {
            if getViewContext().hasChanges{
                try? self.getViewContext().save()
            }
        }
        if getBackgroundViewContext().hasChanges {
            try? self.getBackgroundViewContext().save()
       }
    }
}

extension DatabaseManager: FetchedResultsProtocol{
    func getBackgroundViewContext() -> NSManagedObjectContext {
        return DatabaseManager.dataController.viewContext
    }
    
    func getViewContext() -> NSManagedObjectContext {
        return DatabaseManager.dataController.viewContext
    }
}


extension DatabaseManager: SetupFetchResultsProtocol{
    func setupFetchResultController() {
        do { try self.fetchResultController.performFetch() }
        catch{ fatalError(error.localizedDescription) }
    }
    
    func resetFetchResultController() {
        self.fetchResultController = nil
    }
}
