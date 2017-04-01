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
    public var totalAmmo: Int
    public var maxTotalAmmo: Int
    public var shootRate: Double
    public var reloadTime: Double
    public var weaponType: WeaponType
    
    init(ammo: Int, totalAmmo: Int, shootRate: Double, reloadTime: Double, weaponType: WeaponType) {
        self.weaponType = weaponType
        self.maxAmmo = ammo
        self.ammo = ammo
        self.totalAmmo = totalAmmo
        self.maxTotalAmmo = 900
        self.shootRate = shootRate
        self.reloadTime = reloadTime
    }
    
    func shoot(scene: GameScene, vector: CGVector, x: CGFloat, y: CGFloat, zRotation: CGFloat) {
        let bullet = BulletFactory.getBullet(x: x, y: y, rotation: zRotation)
        scene.addChild(bullet)
        bullet.fly(vector: vector)
    }
    
    func reload() {
        if self.totalAmmo > 2000000 {
            self.ammo = self.maxAmmo
        } else if self.totalAmmo >= self.maxAmmo {
            self.totalAmmo -= self.maxAmmo
            self.ammo = self.maxAmmo
        } else {
            self.ammo = self.totalAmmo
            self.totalAmmo = 0
        }
    }
    
    func getAmmo(amount: Int) {
        self.totalAmmo += amount
        if self.totalAmmo > self.maxTotalAmmo {
            self.totalAmmo = self.maxTotalAmmo
        }
    }
}
