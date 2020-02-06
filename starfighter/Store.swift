//
//  Store.swift
//  starfighter
//
//  Created by Greg on 2/5/20.
//  Copyright © 2020 Caveman Games. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation
import StoreKit

class Store: SKScene, SKPhysicsContactDelegate {
    
    override func sceneDidLoad() {
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playIntro()
        }
        
        // TODO : see if calling the below code after the user is done with the store will impose an ad over the screen. if so th.en we need to navigate back to gamescene when the ad is dismissed.
        
        //                                if let v = self.view,
        //                                    let window = v.window,
        //                                    let root = window.rootViewController,
        //                                    root.isKind(of: GameViewController.self),
        //                                    let gameVC = root as? GameViewController,
        //                                    self.level != 10 {
        //                                    gameVC.presentAd()
    }

}
