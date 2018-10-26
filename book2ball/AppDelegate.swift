//
//  AppDelegate.swift
//  book2ball
//
//  Created by moghid saad on 2018-10-08.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var selectedFacilityData: FacilityData = FacilityData()
    var payment: Payment = Payment()
    var selectedCity : String = ""
    
    //Shanu's part
    var dao : DAO = DAO()
    
    //Gene's part
    var userLoggedIn: Customer = Customer()
    
    //MO's part
    var selectedCourt: Court = Court()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // FirebaseApp.configure()
        //FIRApp.configure()
        if let launchOptions = launchOptions {
            if #available(iOS 9.0, *) {
                if let shortcutItem = launchOptions[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
                    print("Shortcut: \(shortcutItem)")
                }
            }
        }
        
        // Override point for customization after application launch.
        
        //Google client id is require to make Google sign in to work
        GIDSignIn.sharedInstance().clientID = "1086742650619-t0gt0shot9h4u64qbgeh7tar4lujs4iv.apps.googleusercontent.com"
        
        //Facebook SDK requirement
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //PayPal Credentials
        
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AXxgODp_IkCtOtBMkrrfb8VHwjTTxvtiFoXlgTxxyrYPsmW03x4pTbHaxWMfxuyO6Z-xn47rvh8fTRNP",
                                                                PayPalEnvironmentSandbox: "iresh.anthony-facilitator@gmail.com"])
        
        //open the database, drop tables, create tables
        do {
            dao.copyDatabaseIfNeeded()
            try dao.openDB()
            //try dao.dropTable(tableName: "user")
            //try dao.dropTable(tableName: "court")
            //try dao.dropTable(tableName: "facility")
            //try dao.dropTable(tableName: "payment")
            
            //try dao.createTableUser()
            //try dao.createTableFacility()
            //try dao.createTableCourt()
            //try dao.createTablePayment()
            //try dao.insertDefaultFacilities() //enter all default data for facilities, run one time
            //try dao.insertDefaultCourts() //enter all default data for courts, run one time
            print("success")
        } catch {
            print (error);
        }
        return true
    }
    
    //FB required func implementation
    func application(_ application: UIApplication, open url:URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool{
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
        return handled
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

