//
//  OptionsScene.swift
//  Echo-9
//
//  Created by Greg on 8/15/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import SpriteKit
import GameplayKit

class OptionsScene: SKScene {
    
    var musicVolume = Int(100)
    var musicUpNode: SKSpriteNode!
    var musicDownNode: SKSpriteNode!
    var musicVolumeLabel = SKLabelNode()
    
    var soundVolume = Int(100)
    var soundUpNode: SKSpriteNode!
    var soundDownNode: SKSpriteNode!
    var soundVolumeLabel = SKLabelNode()
    
    var backLabel = SKLabelNode()
    var fadeOut = SKAction()
    var fadeIn = SKAction()
    
    override func sceneDidLoad() {
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        
        let createStarAction = SKAction.sequence([SKAction.run(self.createStar), SKAction.wait(forDuration: 3)])
        self.run(SKAction.repeatForever(createStarAction), withKey: "createstar")
        
        fadeOut = SKAction.fadeAlpha(to: 0.2, duration: 0.1)
        fadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.1)
        backLabel = self.childNode(withName: "//backLabel") as! SKLabelNode
        musicUpNode = self.childNode(withName: "//musicUpNode") as? SKSpriteNode
        musicDownNode = self.childNode(withName: "//musicDownNode") as? SKSpriteNode
        musicVolumeLabel = self.childNode(withName: "//musicVolumeLabel") as! SKLabelNode
        
        soundUpNode = self.childNode(withName: "//soundUpNode") as? SKSpriteNode
        soundDownNode = self.childNode(withName: "//soundDownNode") as? SKSpriteNode
        soundVolumeLabel = self.childNode(withName: "//soundVolumeLabel") as! SKLabelNode
        
        let buttonFadeAction = SKAction.sequence([SKAction.run(buttonFade), SKAction.wait(forDuration: 0.5)])
        run(SKAction.repeatForever(buttonFadeAction))
        
        if let vol = UserDefaults.standard.object(forKey: "savedMusicVolume") as? Int {
            musicVolume = vol
            musicVolumeLabel.text = "\(vol)%"
        } else {
            musicVolumeLabel.text = "100%"
        }
        
        if let vol = UserDefaults.standard.object(forKey: "savedSoundVolume") as? Int {
            soundVolume = vol
            soundVolumeLabel.text = "\(vol)%"
        } else {
            soundVolumeLabel.text = "100%"
        }
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
    
    func buttonFade() {
        let buttonFadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.3)
        let buttonFadeOut = SKAction.fadeAlpha(to: 0.7, duration: 0.3)
        if let musicUp = musicUpNode, let musicDown = musicDownNode {
            musicUp.run(buttonFadeOut) {
                musicUp.run(buttonFadeIn)
            }
            
            musicDown.run(buttonFadeOut) {
                musicDown.run(buttonFadeIn)
            }
        }
        
        if let soundUp = soundUpNode, let soundDown = soundDownNode {
            soundUp.run(buttonFadeOut) {
                soundUp.run(buttonFadeIn)
            }
            
           soundDown.run(buttonFadeOut) {
                soundDown.run(buttonFadeIn)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let app = UIApplication.shared.delegate as? AppDelegate,
            let musicPlayer = app.gameMusicPlayer,
            let soundPlayer = app.gameSoundPlayer else { return }
        
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let volUp = musicUpNode, let volDown = musicDownNode {
                if touchedNode == volUp, musicVolume != 100 {
                    musicVolume += 10
                    musicPlayer.volume += 0.1
                    volUp.run(self.fadeOut, completion: {
                        volUp.run(self.fadeIn, completion: {})
                    })
                } else if touchedNode == volDown, musicVolume != 0 {
                    musicVolume -= 10
                    musicPlayer.volume -= 0.1
                    volDown.run(self.fadeOut, completion: {
                        volDown.run(self.fadeIn, completion: {})
                    })
                }
                
                musicVolumeLabel.text = "\(musicVolume)%"
                UserDefaults.standard.set(musicVolume, forKey: "savedMusicVolume")
            }
            
            if let volUp = soundUpNode, let volDown = soundDownNode {
                if touchedNode == volUp, soundVolume != 100 {
                    soundVolume += 10
                    soundPlayer.volume += 0.1
                    volUp.run(self.fadeOut, completion: {
                        volUp.run(self.fadeIn)
                    })
                } else if touchedNode == volDown, soundVolume != 0 {
                    soundVolume -= 10
                    soundPlayer.volume -= 0.1
                    volDown.run(self.fadeOut, completion: {
                        volDown.run(self.fadeIn)
                    })
                }
                
                soundVolumeLabel.text = "\(soundVolume)%"
                UserDefaults.standard.set(soundVolume, forKey: "savedSoundVolume")
            }
            
            if touchedNode == backLabel,
                let view = self.view as SKView?,
                let menuScene = SKScene(fileNamed: "MenuScene") {
                let transition = SKTransition.fade(withDuration: 1.5)
                menuScene.scaleMode = .aspectFit
                view.ignoresSiblingOrder = true
                backLabel.alpha = 0.5
                view.presentScene(menuScene, transition: transition)
            }
        }
    }
}
