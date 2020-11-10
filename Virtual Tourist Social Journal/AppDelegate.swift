//
//  AppDelegate.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/1/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard!

    var dataController = DataController(modelName: "VirtualTourist")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        instantiateUserDefaultsOnFirstLaunch()
        loadViewContext()
        DatabaseManager.dataController = dataController
        return true
    }
     
    private func instantiateUserDefaultsOnFirstLaunch() {
        if !UserDefaults.standard.bool(forKey: Constants.UserDefaults.AppDelegate.hasAppLunchedBefore){
            
            UserDefaults.standard.set(56 , forKey: Constants.UserDefaults.Coordinate.latitude)
            UserDefaults.standard.set(-101 , forKey: Constants.UserDefaults.Coordinate.logitude)
            UserDefaults.standard.set(31 , forKey: Constants.UserDefaults.Coordinate.latitudeDelta)
            UserDefaults.standard.set(30 , forKey: Constants.UserDefaults.Coordinate.logitudeDelta)
            
            UserDefaults.standard.set(true, forKey: Constants.UserDefaults.AppDelegate.hasAppLunchedBefore)
        }
    }
    private func saveViewContext(){
        try? dataController.viewContext.save()
    }
    
    private func loadViewContext() {
        dataController.load()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        saveViewContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveViewContext()
    }
}

