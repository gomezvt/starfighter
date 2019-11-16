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
    
    var volUpNode: SKSpriteNode!
    var volDownNode: SKSpriteNode!
    
    var upNode: SKSpriteNode!
    var downNode: SKSpriteNode!
    var volumeLabel = SKLabelNode()
    var controlsLabel = SKLabelNode()
    var backLabel = SKLabelNode()
    var fadeOut = SKAction()
    var fadeIn = SKAction()
    var volume = Int(100)

    override func sceneDidLoad() {
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        
        let createStarAction = SKAction.sequence([SKAction.run(self.createStar), SKAction.wait(forDuration: 3)])
        self.run(SKAction.repeatForever(createStarAction), withKey: "createstar")

        fadeOut = SKAction.fadeAlpha(to: 0.2, duration: 0.1)
        fadeIn = SKAction.fadeAlpha(to: 1.0 , duration: 0.1)
        backLabel = self.childNode(withName: "//backLabel") as! SKLabelNode
        volUpNode = self.childNode(withName: "//volUpNode") as? SKSpriteNode
        volDownNode = self.childNode(withName: "//volDownNode") as? SKSpriteNode
        volumeLabel = self.childNode(withName: "//volumeLabel") as! SKLabelNode
        upNode = self.childNode(withName: "//upNode") as? SKSpriteNode
        downNode = self.childNode(withName: "//downNode") as? SKSpriteNode
        controlsLabel = self.childNode(withName: "//controlsLabel") as! SKLabelNode

        let buttonFadeAction = SKAction.sequence([SKAction.run(buttonFade), SKAction.wait(forDuration: 0.5)])
        run(SKAction.repeatForever(buttonFadeAction))
        
        if let vol = UserDefaults.standard.object(forKey: "savedVolume") as? Int {
            volume = vol
            volumeLabel.text = "\(vol)%"
        } else {
            volumeLabel.text = "100%"
        }
        
        if let controls = UserDefaults.standard.object(forKey: "savedControls") as? String {
            controlsLabel.text = controls
        } else {
            controlsLabel.text = "YES"
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
        if let up = upNode, let down = downNode, let volUp = volUpNode, let volDown = volDownNode {
            up.run(buttonFadeOut) {
                up.run(buttonFadeIn) {
                }
            }
            
            down.run(buttonFadeOut) {
                down.run(buttonFadeIn) {
                }
            }
            
            volUp.run(buttonFadeOut) {
                volUp.run(buttonFadeIn) {
                }
            }
            
            volDown.run(buttonFadeOut) {
                volDown.run(buttonFadeIn) {
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let up = upNode, let down = downNode, let volUp = volUpNode, let volDown = volDownNode {
                if touchedNode == volUp, volume != 100 {
                    volume += 10
                    app.gameMusicPlayer?.volume += 0.1
                    volUp.run(self.fadeOut, completion: {
                        volUp.run(self.fadeIn, completion: {})
                    })
                } else if touchedNode == volDown, volume != 0 {
                    volume -= 10
                    app.gameMusicPlayer?.volume -= 0.1
                    volDown.run(self.fadeOut, completion: {
                        volDown.run(self.fadeIn, completion: {})
                    })
                }
                
                if touchedNode == up {
                    controlsLabel.text = "YES"
                        up.run(self.fadeOut, completion: {
                            up.run(self.fadeIn, completion: {})
                        })
                } else if touchedNode == down {
                    controlsLabel.text = "NO"
                        down.run(self.fadeOut, completion: {
                            down.run(self.fadeIn, completion: {})
                        })
                }
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
    
        volumeLabel.text = "\(volume)%"
        UserDefaults.standard.set(volume, forKey: "savedVolume")
        UserDefaults.standard.set(controlsLabel.text, forKey: "savedControls")
    }
}
