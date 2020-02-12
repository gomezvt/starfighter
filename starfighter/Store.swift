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

enum Item: String {
    case sgun
    case sfireball
    case slightning
    case sspread
    case stomahawk
    case ssentinel
    case sbomb
    case sshield
    case slife
    case scoin1
    case scoin2
    case scoin3
    case none
}

class Store: SKScene, SKPhysicsContactDelegate {
    var gameStarted = Bool(false)
    var storeItem: Item = .none
    var currentType: WeaponType = .Gun
    var exit = SKLabelNode()
    var buy = SKLabelNode()
    
    var shield = Int(0)
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
    var shieldLabel = SKLabelNode()
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
        
        shieldLabel = self.childNode(withName: "//shieldLabel") as! SKLabelNode
        bombCountLabel = self.childNode(withName: "//bombLabel") as! SKLabelNode
        lifeLabel = self.childNode(withName: "//lifeLabel") as! SKLabelNode
        selectedWeapon = self.childNode(withName: "//sweapon") as? SKSpriteNode
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
        
        if let shield = UserDefaults.standard.object(forKey: "shield") as? Int {
            self.shield = shield
            shieldLabel.text = "\(shield)%"
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
                    gameStarted == true,
                    let gameVC = root as? GameViewController {
                    gameVC.presentAd()
                } else if let view = self.view as SKView?,
                    let menuScene = SKScene(fileNamed: "MenuScene") {
                    app.playMenuItemSound()
                    let transition = SKTransition.fade(withDuration: 1.5)
                    menuScene.scaleMode = .aspectFit
                    view.ignoresSiblingOrder = true
                    view.presentScene(menuScene, transition: transition)
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
                
                if let name = touchedNode.name,
                    let item = Item(rawValue: name) {
                    buy.fontColor = UIColor.systemTeal
                    app.playMenuItemSound()
                    touchedNode.alpha = 0.3
                    selectedItem = touchedNode
                    storeItem = item
                }
            } else if touchedNode == buy,
                let item = selectedItem,
                let storeItem = self.storeItem as Item? {
                item.alpha = 0.3
                
                switch storeItem {
                    case .sgun:
                        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue, // ********* BUY GUN *********
                            let currentType = WeaponType(rawValue: type),
                            coins >= 50 {
                            if WeaponType.Gun != currentType {
                                wepCount = 1
                                app.playNewWeapon()
                                bar.texture = SKTexture(imageNamed: "bar")
                                selectedWeapon.texture = Textures.guntexture
                                UserDefaults.standard.setValue(WeaponType.Gun.rawValue, forKey: "weaponType")
                                coins -= 50
                                
                            } else if wepCount < 5 {
                                app.playLevelUp()
                                wepCount += 1
                                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
                                coins -= 50
                            } else {
                                app.playFail()
                            }
                            coinlabel.text = "\(coins)"
                            UserDefaults.standard.setValue(coins, forKey: "coins")
                            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
                    }
                    case .sfireball:
                        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue, // ********* BUY FIREBALL *********
                            let currentType = WeaponType(rawValue: type),
                            coins >= 50 {
                            if WeaponType.Fireball != currentType {
                                wepCount = 1
                                app.playNewWeapon()
                                bar.texture = SKTexture(imageNamed: "bar")
                                selectedWeapon.texture = Textures.fireballtexture
                                UserDefaults.standard.setValue(WeaponType.Fireball.rawValue, forKey: "weaponType")
                                coins -= 50
                            } else if wepCount < 5 {
                                app.playLevelUp()
                                wepCount += 1
                                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
                                coins -= 50
                            } else {
                                app.playFail()
                            }
                            coinlabel.text = "\(coins)"
                            UserDefaults.standard.setValue(coins, forKey: "coins")
                            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
                    }
                    case .slightning:
                        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue, // ********* BUY LIGHTNING *********
                            let currentType = WeaponType(rawValue: type),
                            coins >= 100 {
                            if WeaponType.Lightning != currentType {
                                wepCount = 1
                                app.playNewWeapon()
                                bar.texture = SKTexture(imageNamed: "bar")
                                selectedWeapon.texture = Textures.lightningtexture
                                coins -= 100
                                UserDefaults.standard.setValue(WeaponType.Lightning.rawValue, forKey: "weaponType")
                            } else if wepCount < 5 {
                                app.playLevelUp()
                                wepCount += 1
                                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
                                coins -= 100
                            } else {
                                app.playFail()
                            }
                            coinlabel.text = "\(coins)"
                            UserDefaults.standard.setValue(coins, forKey: "coins")
                            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
                    }
                    case .sspread:
                        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue, // ********* BUY SPREAD *********
                            let currentType = WeaponType(rawValue: type),
                            coins >= 100 {
                            if WeaponType.Spread != currentType {
                                wepCount = 1
                                app.playNewWeapon()
                                bar.texture = SKTexture(imageNamed: "bar")
                                selectedWeapon.texture = Textures.spreadtexture
                                UserDefaults.standard.setValue(WeaponType.Spread.rawValue, forKey: "weaponType")
                                coins -= 100
                            } else if wepCount < 5 {
                                app.playLevelUp()
                                wepCount += 1
                                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
                                coins -= 100
                            } else {
                                app.playFail()
                            }
                            coinlabel.text = "\(coins)"
                            UserDefaults.standard.setValue(coins, forKey: "coins")
                            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
                    }
                    case .stomahawk:
                        if let type = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue, // ********* BUY MISSILES *********
                            let currentType = WeaponType(rawValue: type),
                            coins >= 150 {
                            if WeaponType.Tomahawk != currentType {
                                wepCount = 1
                                app.playNewWeapon()
                                bar.texture = SKTexture(imageNamed: "bar")
                                selectedWeapon.texture = Textures.tomahawktexture
                                UserDefaults.standard.setValue(WeaponType.Tomahawk.rawValue, forKey: "weaponType")
                                coins -= 150
                            } else if wepCount < 5 {
                                app.playLevelUp()
                                wepCount += 1
                                bar.texture = SKTexture(imageNamed: "bar\(wepCount)")
                                coins -= 150
                            } else {
                                app.playFail()
                            }
                            coinlabel.text = "\(coins)"
                            UserDefaults.standard.setValue(coins, forKey: "coins")
                            UserDefaults.standard.setValue(wepCount, forKey: "weaponCount")
                    }
                    case .ssentinel:
                        guard var sentinelDur = UserDefaults.standard.object(forKey: "sentinelDur") as? Int,
                            sentinelDur < 30,
                            coins >= 150 else {
                                app.playFail()
                                
                                return
                        }
                        
                        app.playNewWeapon()
                        coins -= 150
                        coinlabel.text = "\(coins)"
                        UserDefaults.standard.setValue(coins, forKey: "coins")
                        sentinelDur = 30
                        sentinelLabel.text = "\(sentinelDur)"
                        UserDefaults.standard.setValue(sentinelDur, forKey: "sentinelDur") // ********* BUY SENTINEL *********
                    case .sbomb:
                        guard coins >= 150 else {
                            app.playFail()
                            
                            return
                        }
                        
                        app.playNewWeapon()
                        coins -= 150
                        coinlabel.text = "\(coins)"
                        UserDefaults.standard.setValue(coins, forKey: "coins")
                        megaBombCount += 1
                        bombCountLabel.text = "\(megaBombCount)"
                        UserDefaults.standard.setValue(megaBombCount, forKey: "bombs") // ********* BUY MEGABOMB *********
                    case .sshield:
                        var shield = UserDefaults.standard.object(forKey: "shield") as? Int ?? 0
                        if shield < 100, coins >= 600 {
                            app.playNewWeapon()
                            coins -= 150
                            coinlabel.text = "\(coins)"
                            UserDefaults.standard.setValue(coins, forKey: "coins")
                            shield = 100
                            shieldLabel.text = "\(shield)%"
                            UserDefaults.standard.setValue(shield, forKey: "shield") // ********* BUY SHIELD *********
                        } else {
                            app.playFail()
                    }
                    case .slife:
                        guard coins >= 200 else {
                            app.playFail()
                            
                            return
                        }
                        
                        app.playLife()
                        coins -= 200
                        coinlabel.text = "\(coins)"
                        UserDefaults.standard.setValue(coins, forKey: "coins") // ********* BUY LIFE *********
                        lives += 1
                        lifeLabel.text = "\(lives)"
                        UserDefaults.standard.setValue(lives, forKey: "lives")
                    case .scoin1:
                        coins += 100
                        coinlabel.text = "\(coins)"
                        UserDefaults.standard.setValue(coins, forKey: "coins") // ********* BUY 100 COINS *********
                        app.playCoins()
                    case .scoin2:
                        coins += 300
                        coinlabel.text = "\(coins)"
                        UserDefaults.standard.setValue(coins, forKey: "coins") // ********* BUY 300 COINS *********
                        app.playCoins()
                    case .scoin3:
                        coins += 500
                        coinlabel.text = "\(coins)"
                        UserDefaults.standard.setValue(coins, forKey: "coins") // ********* BUY 500 COINS *********
                        app.playCoins()
                    default:
                        break
                }
            } else {
                buy.fontColor = UIColor.systemBlue
                selectedItem = nil
            }
        }
    }
}
