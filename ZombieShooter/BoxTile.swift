//
//  BoxTile.swift
//  ZombieShooter
//
//  Created by JT on 3/23/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class BoxTile : SKSpriteNode {
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.lightingBitMask = 1
        self.shadowedBitMask = 1
        self.shadowCastBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = false
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.categoryBitMask = PhysicsCategories.Box
        self.physicsBody?.collisionBitMask = PhysicsCategories.Player | PhysicsCategories.Zombie | PhysicsCategories.Box | PhysicsCategories.Wall
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
