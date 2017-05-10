//
//  AppDelegate.swift
//  BeerBeacon
//
//  Created by Bruno Lemgruber on 15/02/17.
//  Copyright © 2017 Bruno Lemgruber. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,ESTSecureBeaconManagerDelegate {

    var window: UIWindow?

    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound];
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString:"0C0C7716-EE41-2AAA-A113-63E683E83A4F")! as UUID, major: 2138, minor: 26902, identifier: "monitored region")
    let beaconManager = ESTSecureBeaconManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        OneSignal.initWithLaunchOptions(launchOptions, appId: "42f9ce69-ceea-42b3-8639-68e0ecf6f9f6")
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
       
        FIRApp.configure()
        
        ESTConfig.setupAppID("beerbeacon-lju", andAppToken: "a97dcc9e7ad472e291b61cc8680297dc")
        
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        
        self.region.notifyOnEntry = true
        self.region.notifyOnExit = true
        self.beaconManager.startMonitoring(for: region)
        
        //self.beaconManager.startRangingBeacons(in: region)
        
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                 print("Notification not allowed")
            }
        }
        
        return true
    }
    
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("didEnter")
        self.beaconManager.startRangingBeacons(in: region)
        
        let content = UNMutableNotificationContent()
        content.title = "BeerBeacon"
        content.body = "Taps te esperando.Cheers!"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1.0,
            repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "BeerBeacon",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(
            request, withCompletionHandler: nil)

    }
    
    func beaconManager(_ manager: Any, monitoringDidFailFor region: CLBeaconRegion?, withError error: Error) {
        print(error)
    }
    
    func beaconManager(_ manager: Any, didFailWithError error: Error) {
        print(error)
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("didExit")
        self.beaconManager.stopRangingBeacons(in: region)
    }
    
    func beaconManager(_ manager: Any, didDetermineState state: CLRegionState, for region: CLBeaconRegion) {
         //0 = unknown, 1 = inside, 2 = outside.
        print(state.rawValue)
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [ESTBeacon], in region: CLBeaconRegion) {
//        rssi - quanto mais proximo de 0 mais proximo está do beacon
//        if(beacons.count > 0){
//            print(beacons[0].proximity)
//            print(beacons[0].rssi)
//        }
        
        let knownBeacons = beacons.filter{$0.proximity != CLProximity.unknown}
        if(knownBeacons.count > 0){
            let closestBeancon = knownBeacons[0] as ESTBeacon
            print(closestBeancon.proximity)
            print(closestBeancon.rssi)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

