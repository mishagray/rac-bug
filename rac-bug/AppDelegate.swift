//
//  AppDelegate.swift
//  rac-bug
//
//  Created by Jeremie Girault on 11/09/2015.
//  Copyright (c) 2015 Jeremie Girault. All rights reserved.
//

import UIKit
import ReactiveCocoa

enum BugType {
    case NoBug
    case Bug1
    case Bug2
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func signalProducers(bug bug: BugType) {
        let scheduler = QueueScheduler(qos: QOS_CLASS_DEFAULT, name: "rac-bug.first")
        
        let signals = (0..<1000).map { _ -> SignalProducer<Void, NoError> in
            if bug == .Bug1 {
                return SignalProducer<Void, NoError>.empty.startOn(scheduler)
            }
            return SignalProducer<Void, NoError>.empty
        }
        
        if bug == .Bug2 {
            combineLatest(signals).startOn(scheduler).start()
        } else {
            combineLatest(signals).start()
        }
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        signalProducers(bug: .Bug1)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

