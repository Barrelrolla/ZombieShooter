//
//  Zombie.swift
//  ZombieShooter
//
//  Created by JT on 3/22/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class Zombie : SKSpriteNode {
    private var health : Int
    
    init(texture: SKTexture!, health: Int, scale: CGSize) {
        self.health = health
        super.init(texture: texture, color: SKColor.red, size: texture.size())
        self.name = "zombie"
        self.scale(to: scale)
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.lightingBitMask = 1
        self.shadowCastBitMask = 1
        self.shadowedBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Zombie
        self.physicsBody?.collisionBitMask = PhysicsCategories.Player & PhysicsCategories.Bullet
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
    }
    
    func takeDamage(amount: Int) {
        health -= amount
        if health <= 0 {
            self.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.health = 1
        super.init(coder: aDecoder)
    }
}
