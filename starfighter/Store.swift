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
    
    var exit = SKLabelNode()
    
    var lives = Int(0)
    var megaBombCount = Int(0)
    var coins = Int(0)
    var sentinelDur = Int(0)
    var wepCount = Int(0)
    
    var bombCountLabel = SKLabelNode()
    var lifeLabel = SKLabelNode()
    var selectedWeapon: SKSpriteNode!
    var coinlabel = SKLabelNode()
    var sentinelLabel = SKLabelNode()
    var bar: SKSpriteNode!
    var barTexture: SKTexture!
    
    @objc func adWasDismissed(_ notification: Notification) {
        if let view = self.view,
            let gameScene = SKScene(fileNamed: "GameScene") as? GameScene {
            gameScene.scaleMode = .aspectFit
            let transition = SKTransition.fade(withDuration: 1.5)
            view.presentScene(gameScene, transition: transition)
        }
    }
    
    override func sceneDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(adWasDismissed), name: NSNotification.Name(rawValue: "adWasDismissed"), object: nil)
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        exit = self.childNode(withName: "//exit") as! SKLabelNode
        
        bombCountLabel = self.childNode(withName: "//bombLabel") as! SKLabelNode
        lifeLabel = self.childNode(withName: "//lifeLabel") as! SKLabelNode
        selectedWeapon = self.childNode(withName: "//weapon") as? SKSpriteNode
        coinlabel = self.childNode(withName: "//coinlabel") as! SKLabelNode
        sentinelLabel = self.childNode(withName: "//sentinelLabel") as! SKLabelNode
        bar = self.childNode(withName: "//bar") as? SKSpriteNode
        
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.playIntro()
        }
        
        if let sentinelDur = UserDefaults.standard.object(forKey: "sentinelDur") as? Int {
            self.sentinelDur = sentinelDur
            sentinelLabel.text = "\(sentinelDur)"
        }
        
        if let bombs = UserDefaults.standard.object(forKey: "bombs") as? Int {
            megaBombCount = bombs
            bombCountLabel.text = "\(megaBombCount)"
        }
        
        if let coins = UserDefaults.standard.object(forKey: "coins") as? Int {
            self.coins = coins
            coinlabel.text = "\(coins)"
        }

        if let lives = UserDefaults.standard.object(forKey: "lives") as? Int {
            self.lives = lives
            lifeLabel.text = "\(lives)"
        }
        
        if let wepCount = UserDefaults.standard.object(forKey: "weaponCount") as? Int {
            self.wepCount = wepCount
            if wepCount == 1 {
                bar.texture = SKTexture(imageNamed: "bar")
            } else {
                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
            }
        }
        
        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue,
            let wep = WeaponType(rawValue: type) {
            if wep == .Gun {
                selectedWeapon.texture = Textures.guntexture
            } else if wep == .Fireball {
                selectedWeapon.texture = Textures.fireballtexture
            } else if wep == .Spread {
                selectedWeapon.texture = Textures.spreadtexture
            } else if wep == .Lightning {
                selectedWeapon.texture = Textures.lightningtexture
            } else if wep == .Tomahawk {
                selectedWeapon.texture = Textures.tomahawktexture
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // TODO: ONLY let the user select sentinel if their current sentinelDur is less than 30 or else return (use guard)
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if touchedNode == exit {
                if let v = self.view,
                    let window = v.window,
                    let root = window.rootViewController,
                    root.isKind(of: GameViewController.self),
                    let gameVC = root as? GameViewController {
                    gameVC.presentAd()
                }
            }
        }
    }
    
}
