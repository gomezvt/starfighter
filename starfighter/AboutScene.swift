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
    var privacy = SKLabelNode()
    
    override func sceneDidLoad() {
        scene?.scaleMode = SKSceneScaleMode.aspectFit
        self.backLabel = self.childNode(withName: "//backLabel") as! SKLabelNode
        self.privacy = self.childNode(withName: "//privacy") as! SKLabelNode
        let createStarAction = SKAction.sequence([SKAction.run(self.createStar), SKAction.wait(forDuration: 3)])
        self.run(SKAction.repeatForever(createStarAction), withKey: "createstar")
    }
    
    @objc func createStar() {
        let small = SKSpriteNode(imageNamed: "bgstar")
        small.alpha = 0.7
        small.size = CGSize(width: 15, height: 15)
        small.name = "star"
        
        let medium = SKSpriteNode(imageNamed: "bgstar")
        medium.alpha = 0.5
        medium.size = CGSize(width: 25, height: 25)
        medium.name = "star"
        
        let large = SKSpriteNode(imageNamed: "bgstar")
        large.alpha = 0.3
        large.size = CGSize(width: 35, height: 35)
        large.name = "star"
        
        let stars = [small, medium, large]
        if let star = stars.randomElement() {
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let app = UIApplication.shared.delegate as? AppDelegate else { return }
        
        for touch: AnyObject in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode == backLabel,
                let view = self.view as SKView?,
                let menuScene = SKScene(fileNamed: "MenuScene") {
                app.playMenuItemSound()
                let transition = SKTransition.fade(withDuration: 1.5)
                menuScene.scaleMode = .aspectFit
                view.ignoresSiblingOrder = true
                backLabel.alpha = 0.5
                view.presentScene(menuScene, transition: transition)
            } else if touchedNode == privacy,
                let url = URL(string: "https://www.facebook.com/notes/star-fighter-ios-app/star-fighter-privacy-policy/650652012018608/") {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil);
                app.playMenuItemSound()
            }
        }
    }
    
}


