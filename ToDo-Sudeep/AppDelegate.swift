//
//  AppDelegate.swift
//  ToDo-Sudeep
//
//  Created by Sudip on 10/14/18.
//  Copyright © 2018 Sudeepasa. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        //to check if the realm is installing correctly or not 
        
        do{
            let realm = try Realm()
        }
        catch {
            print("Error installing Realm \(error)")
        }
        return true
        
    }

}
