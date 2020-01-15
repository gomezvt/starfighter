//
//  MenuScene.swift
//  Echo-9
//
//  Created by Greg on 8/14/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class MenuScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var lastUpdateTime : TimeInterval = 0
    var titleLabel : SKLabelNode?
    var newGameLabel : SKLabelNode?
    var optionsLabel : SKLabelNode?
    var aboutLabel : SKLabelNode?
    var clearUserDefaults: Bool = false
    var shipExhaustArray = Array<SKTexture>()
    let shipAtlas = SKTextureAtlas(named:"shipexhaust")
    var ship: SKSpriteNode!
    var titleLabelPosition = CGPoint()
    var menuPlayer: AVAudioPlayer?

    override func sceneDidLoad() {
        menuPlayer?.prepareToPlay()
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust"))
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust2"))
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust3"))
        shipExhaustArray.append(shipAtlas.textureNamed("shipexhaust4"))
        
        let createStarAction = SKAction.sequence([SKAction.run(self.createStar), SKAction.wait(forDuration: 3)])
        self.run(SKAction.repeatForever(createStarAction), withKey: "createstar")
        
        let cometAction = SKAction.sequence([SKAction.run(self.createComet), SKAction.wait(forDuration: 20)])
        run(SKAction.repeatForever(cometAction), withKey: "createcomet")
        
        createShip()
       
        lastUpdateTime = 0
        titleLabel = self.childNode(withName: "//titleLabel") as? SKLabelNode
        newGameLabel = self.childNode(withName: "//newGameLabel") as? SKLabelNode
        optionsLabel = self.childNode(withName: "//optionsLabel") as? SKLabelNode
        aboutLabel = self.childNode(withName: "//aboutLabel") as? SKLabelNode
        
        aboutLabel?.text = NSLocalizedString("About", comment: "")
        optionsLabel?.text = NSLocalizedString("Options", comment: "")
        
        if let _ = UserDefaults.standard.object(forKey: "level") as? Int,
            let _ = UserDefaults.standard.object(forKey: "lives") as? Int,
            let _ = UserDefaults.standard.object(forKey: "weaponCount") as? Int,
            let _ = UserDefaults.standard.object(forKey: "weaponType") as? WeaponType.RawValue {
            // Continue
            newGameLabel?.text = NSLocalizedString("Continue", comment: "")
        } else {
            //Start
            newGameLabel?.text = NSLocalizedString("Start", comment: "")
        }
        
        let fadeAction = SKAction.sequence([SKAction.run(fadeLabel), SKAction.wait(forDuration: 2)])
        run(SKAction.repeatForever(fadeAction), withKey: "fade")
        
        guard let title = titleLabel else { return }
        
        titleLabelPosition = title.position
        let jiggle = SKAction.sequence([SKAction.run(jigglelabel), SKAction.wait(forDuration: 2)])
        run(SKAction.repeatForever(jiggle), withKey: "jiggle")
    }
    
    @objc func createComet() {
        let comet = SKSpriteNode(imageNamed: "comet")
        comet.size = CGSize(width: 80, height: 30)
        comet.name = "comet"
        comet.alpha = 0.5
        // Add enemy at random height
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        comet.position = CGPoint(x:width + 150, y: randomY)
        comet.zPosition = 2
        self.addChild(comet)
        
        // Move enemy at random duration
        let action = SKAction.moveTo(x: -width - 150, duration: 3)
        action.timingMode = .linear
        comet.run(action, withKey: "cometMoveAction")
    }
    
    @objc func createStar() {
        let star = SKSpriteNode(imageNamed: "bgstar")
        star.name = "star"
        
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        
        star.position = CGPoint(x:(view?.frame.maxX)! + 150, y: randomY)
        star.zPosition = 1
        self.addChild(star)
        
        let width = UIScreen.main.bounds.width
        let randomDuration = TimeInterval(CGFloat(arc4random() % UInt32(30) + 15))
        let action = SKAction.moveTo(x: -width * 2, duration: randomDuration)
        action.timingMode = .linear
        star.run(action)
    }
    
    func jigglelabel() {
        guard let label = titleLabel else { return }

        let left = SKAction.moveTo(x: label.position.x - 10, duration: 0.1)
        let right = SKAction.moveTo(x: titleLabelPosition.x, duration: 0.1)
        label.run(left) {
            label.run(right) {
                
            }
        }
    }
    
    func fadeLabel() {
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        let fadeOut = SKAction.fadeAlpha(to: 0.5, duration: 0.5)
        
        guard let start = newGameLabel else { return }
        
        start.run(fadeOut) {
            start.run(fadeIn) {
                
            }
        }
    }
    
    func createShip() {
        let ship = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("player"))
        ship.size = CGSize(width: 120, height: 120)
        ship.name = "ship"
        let width = UIScreen.main.bounds.width
        let bot = -UIScreen.main.bounds.height + 150
        let top = UIScreen.main.bounds.height - 125
        let randomY = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(top - bot) + min(top, bot)
        
        ship.position = CGPoint(x: -width - 160, y: randomY)
        ship.zPosition = 2
        addChild(ship)
        
        let shipExhaust = SKSpriteNode(texture: SKTextureAtlas(named:"shipexhaust").textureNamed("shipexhaust"))
        ship.addChild(shipExhaust)
        
        let animateexhaust = SKAction.animate(with: self.shipExhaustArray, timePerFrame: 0.1)
        shipExhaust.run(SKAction.repeatForever(animateexhaust), withKey: "exhaustAction")
        shipExhaust.position = CGPoint(x: -80, y: 0)
        
        let randomMoveDuration = TimeInterval(CGFloat(arc4random() % UInt32(30))) + 5
        let action = SKAction.moveTo(x: width + 250, duration: randomMoveDuration)
        action.timingMode = .linear
        
        let wait = SKAction.wait(forDuration: 1.0)
        let seq = SKAction.sequence([wait, SKAction.repeatForever(action)])
        ship.run(SKAction.repeatForever(seq))
        self.ship = ship
    }
    
    func clearDefaults() {
        UserDefaults.standard.removeObject(forKey: "level")
        UserDefaults.standard.removeObject(forKey: "lives")
        UserDefaults.standard.removeObject(forKey: "weaponCount")
        UserDefaults.standard.removeObject(forKey: "weaponType")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode.isKind(of: SKLabelNode.self) && touchedNode != titleLabel,
                let view = self.view as SKView? {
                let transition = SKTransition.fade(withDuration: 1.5)
                if touchedNode == newGameLabel {
                    playStartSound()
                    newGameLabel?.alpha = 0.5
                    guard let didAcknowledge = UserDefaults.standard.value(forKey: "acknowledgedTutorial") as? Bool,
                        didAcknowledge == true else {
                            if let tutorialScene = SKScene(fileNamed: "TutorialScene") {
                                tutorialScene.scaleMode = .aspectFit
                                let transition = SKTransition.fade(withDuration: 1.5)
                                view.presentScene(tutorialScene, transition: transition)
                            }
                            
                            return
                    }
                    
                    if let gameScene = SKScene(fileNamed: "GameScene") as? GameScene {
                        gameScene.scaleMode = .aspectFit
                        gameScene.isContinuing = newGameLabel?.text == NSLocalizedString("Continue", comment: "") ? true : false
                        view.presentScene(gameScene, transition: transition)
                    }
                } else if touchedNode == optionsLabel,
                    let optionsScene = SKScene(fileNamed: "OptionsScene") {
                    optionsScene.scaleMode = .aspectFit
                    optionsLabel?.alpha = 0.5
                    view.presentScene(optionsScene, transition: transition)
                } else if touchedNode == aboutLabel,
                    let aboutScene = SKScene(fileNamed: "AboutScene") {
                    aboutScene.scaleMode = .aspectFit
                    aboutLabel?.alpha = 0.5
                    view.presentScene(aboutScene, transition: transition)
                }
                view.ignoresSiblingOrder = true
            }
        }
    }
    
    func playStartSound() {
        if let url = Bundle.main.url(forResource: "Start", withExtension: "wav", subdirectory: "/sounds") {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
                try AVAudioSession.sharedInstance().setActive(true)
                menuPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                menuPlayer?.volume = 0.2
                menuPlayer?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ship == nil {
            createShip()
        } else if ship.position.x >= frame.maxX + 250 {
            ship.removeFromParent()
            ship = nil
        }

        if let app = UIApplication.shared.delegate as? AppDelegate {
            if app.gameMusicPlayer?.isPlaying == false {
                app.gameMusicPlayer?.play()
            }
        }
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
        return input.rawValue
    }
    
}
