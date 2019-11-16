//
//  AboutScene.swift
//  Echo-9
//
//  Created by Greg on 8/15/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import SpriteKit
import GameplayKit

class AboutScene: SKScene {
    
    var backLabel = SKLabelNode()
    
    override func sceneDidLoad() {
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        self.backLabel = self.childNode(withName: "//backLabel") as! SKLabelNode
        let createStarAction = SKAction.sequence([SKAction.run(self.createStar), SKAction.wait(forDuration: 3)])
        self.run(SKAction.repeatForever(createStarAction), withKey: "createstar")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode == backLabel,
                let view = self.view as SKView?,
                let menuScene = SKScene(fileNamed: "MenuScene") {
                let transition = SKTransition.fade(withDuration: 1)
                menuScene.scaleMode = .aspectFit
                view.ignoresSiblingOrder = true
                backLabel.alpha = 0.5
                view.presentScene(menuScene, transition: transition)
            }
        }
    }
    
}


