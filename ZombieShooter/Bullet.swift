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
    public let moveSpeed: Double
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        self.moveSpeed = 0.7
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.zPosition = SpriteLayer.Bullets
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Bullet
        self.physicsBody?.collisionBitMask = PhysicsCategories.Zombie
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Wall | PhysicsCategories.Zombie
        self.lightingBitMask = 1
    }
    
    func fly(vector: CGVector) {
        let move = SKAction.move(by: vector, duration: self.moveSpeed)
        let remove = SKAction.removeFromParent()
        let moveAndRemove = SKAction.sequence([move, remove])
        self.run(moveAndRemove)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.moveSpeed = 1
        super.init(coder: aDecoder)
    }
}
