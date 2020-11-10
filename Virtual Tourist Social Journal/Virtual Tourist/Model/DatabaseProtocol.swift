//
//  DatabaseProtocol.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import CoreData

protocol DatabaseRepositoryProtocol {
    func getAll() -> [NSManagedObject]?
    func getBy(objectID: NSManagedObjectID, completionHandler:@escaping (_ place:NSManagedObject)->Void)
    func insert(object: NSManagedObject, completionHandler: @escaping(_ objectID: NSManagedObjectID)->Void)
    func update(object: NSManagedObject)
    func delete(object: NSManagedObject)
    func deleteObject(at indexPath: IndexPath)
    func deleteAllObjects()
    func save()
}

protocol FetchedResultsProtocol {
    var fetchResultController:NSFetchedResultsController<NSManagedObject>! {get set}
    
    func getViewContext() -> NSManagedObjectContext
    func getBackgroundViewContext() -> NSManagedObjectContext
}

protocol SetupFetchResultsProtocol{
    func setupFetchResultController()
    func resetFetchResultController()
}
 
