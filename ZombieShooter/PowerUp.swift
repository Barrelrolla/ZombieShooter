//
//  PowerUp.swift
//  ZombieShooter
//
//  Created by JT on 3/29/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class PowerUp: SKSpriteNode {
    init(texture: SKTexture, x: CGFloat, y: CGFloat) {
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        self.position.x = x
        self.position.y = y
        self.zPosition = SpriteLayer.BackgroundTextures
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.PowerUp
        self.physicsBody?.collisionBitMask = PhysicsCategories.Box
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        self.scale(to: CGSize(width: self.size.width * 0.7, height: self.size.height * 0.7))
    }
    
    func executeEffect() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
