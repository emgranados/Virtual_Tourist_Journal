//
//  Datacontroller.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    var persistantContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return self.persistantContainer.viewContext
    }
    var backgroundViewContext: NSManagedObjectContext?
    
    init(modelName: String) {
        persistantContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureViewContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundViewContext?.automaticallyMergesChangesFromParent = true
        
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        backgroundViewContext?.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    func load(completionHandler:(()->Void)? = nil) {
        persistantContainer.loadPersistentStores {
            (storeDescription, error) in
            guard error == nil else{
            fatalError(error!.localizedDescription)
            }
            self.configureViewContexts()
            completionHandler?()
     
        }
    }
}


extension DataController{
    @objc func autoSaveViewContext(interval: TimeInterval = 30){
        print("autosaving...")
        guard interval > 0 else {
            print("can't autosave after negative time interval.")
            return
        }
        
        if viewContext.hasChanges{
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval){
            self.autoSaveViewContext()
        }
    }
}
