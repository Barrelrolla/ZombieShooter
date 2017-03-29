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
    public let maxAmmo: Int
    public var shootRate: Double
    public var reloadTime: Double
    public var weaponType: WeaponType
    
    init(ammo: Int, shootRate: Double, reloadTime: Double, weaponType: WeaponType) {
        self.weaponType = weaponType
        self.maxAmmo = ammo
        self.ammo = ammo
        self.shootRate = shootRate
        self.reloadTime = reloadTime
    }
    
    func shoot(scene: GameScene, vector: CGVector, x: CGFloat, y: CGFloat, zRotation: CGFloat) {
        let bullet = BulletFactory.getBullet(x: x, y: y, rotation: zRotation)
        scene.addChild(bullet)
        bullet.fly(vector: vector)
    }
    
    func reload() {
        self.ammo = self.maxAmmo
    }
}
