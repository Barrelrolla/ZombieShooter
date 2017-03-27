//
//  WeaponFactory.swift
//  ZombieShooter
//
//  Created by JT on 3/27/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class WeaponFactory {
    static func getWeapon(type: WeaponType) -> Weapon {
        switch type {
        case .Pistol:
            return Weapon(ammo: 10, shootRate: 0.3, reloadTime: 0.7)
        case .MachineGun:
            return Weapon(ammo: 30, shootRate: 0.1, reloadTime: 1.5)
        }
    }
}
