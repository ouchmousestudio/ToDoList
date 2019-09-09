//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Miles Fearnall-Williams on 2019/09/02.
//  Copyright © 2019 Miles Fearnall-Williams. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        ..print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()

        }catch {
            print("Error initilizing new Ream \(error)")
        }
    
        
        return true
    }
    
    // MARK: - Core Data stack
    



}

