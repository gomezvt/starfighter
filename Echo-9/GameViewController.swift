//
//  GameViewController.swift
//  Echo-9
//
//  Created by Greg on 8/14/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    var storyScene : StoryScene?
    var app: AppDelegate?

    func presentAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        app?.gameMusicPlayer?.setVolume(0.3, fadeDuration: 1)
        NotificationCenter.default.post(name: Notification.Name("adWasPresented"), object: nil)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        app?.gameMusicPlayer?.setVolume(1, fadeDuration: 1)
        NotificationCenter.default.post(name: Notification.Name("adWasDismissed"), object: nil)
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-7621248326587252/5220265808") //real
//        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910") //test

        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let app = UIApplication.shared.delegate as? AppDelegate {
            self.app = app
        }
        interstitial = createAndLoadInterstitial()
        if let view = self.view as! SKView? {
            
            view.showsNodeCount = false
//            #if DEBUG
//            view.showsNodeCount = true
//            #endif
            presentMenuScene()
//            PRESENT GAME STORY
//            if let storyScene = SKScene(fileNamed: "StoryScene") as! StoryScene? {
//            self.storyScene = storyScene
//            storyScene.scaleMode = .aspectFit
//            view.presentScene(storyScene)
//            }
        }
    }

//    TAP TO DISMISS STORY
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let storyScene = self.storyScene else { return }
//
//        for touch: AnyObject in touches {
//            if let positionInScene = touch.location(in: storyScene) as CGPoint?,
//                let _ = storyScene.atPoint(positionInScene) as SKNode? {
//                presentMenuScene()
//            }
//        }
//    }
    
    func presentMenuScene() {
        guard let view = self.view as! SKView? else { return }
        
        if let menuScene = GKScene(fileNamed: "MenuScene") {
            if let menuNode = menuScene.rootNode as! MenuScene? {
                menuNode.entities = menuScene.entities
                menuNode.graphs = menuScene.graphs
                menuNode.scaleMode = .aspectFit
                //storyScene = nil
                let transition = SKTransition.fade(withDuration: 2)
                view.presentScene(menuNode, transition: transition)
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
