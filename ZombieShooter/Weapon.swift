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
    public var reloadTime: Double
    
    init(ammo: Int, shootRate: Double, reloadTime: Double) {
        self.ammo = ammo
        self.shootRate = shootRate
        self.reloadTime = reloadTime
    }
    
    func shoot(scene: GameScene, vector: CGVector, x: CGFloat, y: CGFloat, zRotation: CGFloat) {
        let bullet = BulletFactory.getBullet(x: x, y: y, rotation: zRotation)
        scene.addChild(bullet)
        bullet.fly(vector: vector)
    }
}
