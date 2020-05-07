
//
//  AppDelegate.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
let APPLANGUAGE = Bundle.main.preferredLocalizations.first
let UserID = UserDefaults.standard.value(forKey: "id")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCu8PQ6sGgxaFT-a6lEEZ2v669XK8APY5c")
        GMSPlacesClient.provideAPIKey("AIzaSyCu8PQ6sGgxaFT-a6lEEZ2v669XK8APY5c")
//        if UserID == nil {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "login")
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewController
//            self.window?.makeKeyAndVisible()
//            
//        }else{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeNC")
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewController
//            self.window?.makeKeyAndVisible()
//        }
        WebServices.instance.getCategory()
        WebServices.instance.getZones()
        WebServices.instance.getAbout()
        WebServices.instance.getTerms()
        WebServices.instance.getPolicy()
        IQKeyboardManager.shared.enable = true

        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

