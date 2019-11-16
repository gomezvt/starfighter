//
//  AppDelegate.swift
//  Echo-9
//
//  Created by Greg on 8/14/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var gameMusicPlayer: AVAudioPlayer?
    var level = Int(0)
    func setMusicVolume() {
        if let savedVolume = UserDefaults.standard.value(forKeyPath: "savedVolume") as? Int {
            if savedVolume == 0 {
                gameMusicPlayer?.volume = 0
            } else if savedVolume == 10 {
                gameMusicPlayer?.volume = 0.1
            } else if savedVolume == 20 {
                gameMusicPlayer?.volume = 0.2
            } else if savedVolume == 30 {
                gameMusicPlayer?.volume = 0.3
            } else if savedVolume == 40 {
                gameMusicPlayer?.volume = 0.4
            } else if savedVolume == 50 {
                gameMusicPlayer?.volume = 0.5
            } else if savedVolume == 60 {
                gameMusicPlayer?.volume = 0.6
            } else if savedVolume == 70 {
                gameMusicPlayer?.volume = 0.7
            } else if savedVolume == 80 {
                gameMusicPlayer?.volume = 0.8
            } else if savedVolume == 90 {
                gameMusicPlayer?.volume = 0.9
            } else if savedVolume == 100 {
                gameMusicPlayer?.volume = 1.0
            }
        } else {
            gameMusicPlayer?.volume = 1.0
        }
    }
    
    func playIntro() {
        if let url = Bundle.main.url(forResource: "menu", withExtension: "caf", subdirectory: "/music") {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
                try AVAudioSession.sharedInstance().setActive(true)
                gameMusicPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.caf.rawValue)
                setMusicVolume()
                gameMusicPlayer?.numberOfLoops = -1
                gameMusicPlayer?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        gameMusicPlayer?.prepareToPlay()
        playIntro()
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.configure(withApplicationID: "ca-app-pub-7621248326587252~4392531186")
        
        // Override point for customization after application launch.
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
        gameMusicPlayer?.prepareToPlay()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
