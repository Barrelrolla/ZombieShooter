//
//  WallTile.swift
//  ZombieShooter
//
//  Created by JT on 3/21/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class WallTile : SKSpriteNode {
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "Wall"
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.lightingBitMask = 1
        self.shadowedBitMask = 1
        self.shadowCastBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Wall
        self.physicsBody?.collisionBitMask = PhysicsCategories.Player | PhysicsCategories.Box
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Bullet
        self.zPosition = SpriteLayer.Walls
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
