//
//  Bullet.swift
//  ZombieShooter
//
//  Created by JT on 3/20/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : SKSpriteNode {
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Bullet
        self.physicsBody?.collisionBitMask = PhysicsCategories.Zombie
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Wall | PhysicsCategories.Zombie
        self.lightingBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
