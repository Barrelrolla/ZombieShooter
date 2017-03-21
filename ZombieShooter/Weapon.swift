//
//  Weapon.swift
//  ZombieShooter
//
//  Created by JT on 3/20/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class Weapon {
    public var ammo: Int
    public var shootRate: Double
    
    init(ammo: Int, shootRate: Double) {
        self.ammo = ammo
        self.shootRate = shootRate
    }
    
    func shoot(scene: GameScene, vector: CGVector, x: CGFloat, y: CGFloat, zRotation: CGFloat) {
        let bullet = Bullet(texture: SKTexture(imageNamed: "bullet"), color: SKColor.yellow, size: CGSize(width:19, height: 10))
        bullet.position = CGPoint(x: x, y: y)
        bullet.zPosition = 1
        bullet.zRotation = zRotation
        bullet.setScale(0.5)
        scene.addChild(bullet)
        let move = SKAction.move(by: vector, duration: 0.7)
        let remove = SKAction.removeFromParent()
        let moveAndRemove = SKAction.sequence([move, remove])
        bullet.run(moveAndRemove)
    }
}
