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

//enum Item: String {
//    case sgun = "sgun"
//    case sfireball = "sfireball"
//    case slightning = "slightning"
//    case sspread = "sspread"
//    case stomahawk = "stomahawk"
//    case ssentinel = "ssentinel"
//    case sbomb = "sbomb"
//    case sshield = "sshield"
//    case slife = "slife"
//    case coin1 = "coin1"
//    case coin2 = "coin2"
//    case coin3 = "coin3"
//    case none = ""
//}

class Store: SKScene, SKPhysicsContactDelegate {
    
    var exit = SKLabelNode()
    var buy = SKLabelNode()
    
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
    var sgun: SKSpriteNode!
    var sfireball: SKSpriteNode!
    var slightning: SKSpriteNode!
    var sspread: SKSpriteNode!
    var stomahawk: SKSpriteNode!
    var ssentinel: SKSpriteNode!
    var sbomb: SKSpriteNode!
    var sshield: SKSpriteNode!
    var slife: SKSpriteNode!
    var scoin1: SKSpriteNode!
    var scoin2: SKSpriteNode!
    var scoin3: SKSpriteNode!
    var selectedItem: SKNode!
    
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
        buy = self.childNode(withName: "//buy") as! SKLabelNode
        
        bombCountLabel = self.childNode(withName: "//bombLabel") as! SKLabelNode
        lifeLabel = self.childNode(withName: "//lifeLabel") as! SKLabelNode
        selectedWeapon = self.childNode(withName: "//weapon") as? SKSpriteNode
        coinlabel = self.childNode(withName: "//coinlabel") as! SKLabelNode
        sentinelLabel = self.childNode(withName: "//sentinelLabel") as! SKLabelNode
        bar = self.childNode(withName: "//bar") as? SKSpriteNode
        
        sgun = self.childNode(withName: "//sgun") as? SKSpriteNode
        sfireball = self.childNode(withName: "//sfireball") as? SKSpriteNode
        slightning = self.childNode(withName: "//slightning") as? SKSpriteNode
        sspread = self.childNode(withName: "//sspread") as? SKSpriteNode
        stomahawk = self.childNode(withName: "//stomahawk") as? SKSpriteNode
        ssentinel = self.childNode(withName: "//ssentinel") as? SKSpriteNode
        sbomb = self.childNode(withName: "//sbomb") as? SKSpriteNode
        sshield = self.childNode(withName: "//sshield") as? SKSpriteNode
        slife = self.childNode(withName: "//slife") as? SKSpriteNode
        scoin1 = self.childNode(withName: "//scoin1") as? SKSpriteNode
        scoin2 = self.childNode(withName: "//scoin2") as? SKSpriteNode
        scoin3 = self.childNode(withName: "//scoin3") as? SKSpriteNode
        
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
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // TODO: ONLY let the user select sentinel if their current sentinelDur is less than 30 or else return (use guard)
        for touch: AnyObject in touches {
            sgun.alpha = 0.1
            sfireball.alpha = 0.1
            sspread.alpha = 0.1
            slightning.alpha = 0.1
            stomahawk.alpha = 0.1
            ssentinel.alpha = 0.1
            sbomb.alpha = 0.1
            sshield.alpha = 0.1
            slife.alpha = 0.1
            scoin1.alpha = 0.1
            scoin2.alpha = 0.1
            scoin3.alpha = 0.1
            exit.fontColor = UIColor.systemTeal
            
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
            } else if touchedNode == sgun ||
                touchedNode == sfireball ||
                touchedNode == sspread ||
                touchedNode == slightning ||
                touchedNode == stomahawk ||
                touchedNode == ssentinel ||
                touchedNode == sbomb ||
                touchedNode == sshield ||
                touchedNode == slife ||
                touchedNode == scoin1 ||
                touchedNode == scoin2 ||
                touchedNode == scoin3 {
                buy.fontColor = UIColor.systemTeal
                app.playMenuItemSound()
                touchedNode.alpha = 0.2
                selectedItem = touchedNode
            } else if touchedNode == buy {
                app.playMenuItemSound()
                selectedItem.alpha = 0.2
            } else {
                buy.fontColor = UIColor.systemBlue
                selectedItem = nil
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
