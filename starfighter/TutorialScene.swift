//
//  TutorialScene.swift
//  Echo-9
//
//  Created by Greg on 11/20/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import SpriteKit
import GameplayKit

struct TutorialTextures {
    static let controlstexture = SKTexture(imageNamed: "tutorial_controls")
    static let nocontrolstexture = SKTexture(imageNamed: "tutorial_nocontrols")
}

class TutorialScene: SKScene {
    var controlsArrow: SKSpriteNode!
    var controlsLabel = SKLabelNode()
    var proceedLabel = SKLabelNode()
    var bg: SKSpriteNode!
    
    func fadeLabel() {
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
        proceedLabel.run(fadeOut) {
            self.proceedLabel.run(fadeIn) {
                
            }
        }
    }

    override func sceneDidLoad() {
        scene?.scaleMode = SKSceneScaleMode.aspectFit

        bg = self.childNode(withName: "//bg") as? SKSpriteNode
        controlsArrow = self.childNode(withName: "//controlsArrow") as? SKSpriteNode
        controlsLabel = self.childNode(withName: "//controlsLabel") as! SKLabelNode
        proceedLabel = self.childNode(withName: "//proceedLabel") as! SKLabelNode

        let fadeAction = SKAction.sequence([SKAction.run(fadeLabel), SKAction.wait(forDuration: 2)])
        run(SKAction.repeatForever(fadeAction))

        if let savedControls = UserDefaults.standard.object(forKey: "savedControls") as? String {
            if savedControls == "NO" {
                controlsArrow.isHidden = true
                controlsLabel.text = "Tap above and below the\nship to move up and down."
                bg.texture = TutorialTextures.nocontrolstexture
            } else {
                controlsArrow.isHidden = false
                controlsLabel.text = "Tap to move up and down."
                bg.texture = TutorialTextures.controlstexture
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _: AnyObject in touches {
            if let gameScene = SKScene(fileNamed: "GameScene") {
                gameScene.scaleMode = .aspectFit
                let transition = SKTransition.fade(withDuration: 1.5)
                view?.presentScene(gameScene, transition: transition)
                UserDefaults.standard.setValue(true, forKey: "acknowledgedTutorial")
            }
        }
    }
    
}
