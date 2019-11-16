//
//  StoryScene.swift
//  Echo-9
//
//  Created by Greg on 8/15/18.
//  Copyright © 2018 Greg Gomez. All rights reserved.
//

import SpriteKit
import GameplayKit

class StoryScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .yellow
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.backgroundColor = .green
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.backgroundColor = .blue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.backgroundColor = .purple
                    }
                }
            }
        }
        
    }
    
}
