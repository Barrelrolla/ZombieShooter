//
//  MedKit.swift
//  ZombieShooter
//
//  Created by JT on 3/29/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class MedKit: PowerUp {
    init(x: CGFloat, y: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "medkit"), x: x, y: y)
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 60),
            SKAction.run {
                self.removeFromParent()
            }
        ]))
    }
    
    override func executeEffect() {
        player.restoreHealth()
        self.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
