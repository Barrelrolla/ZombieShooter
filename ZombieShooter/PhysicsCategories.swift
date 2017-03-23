//
//  PhysicsCategories.swift
//  ZombieShooter
//
//  Created by JT on 3/21/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation

struct PhysicsCategories {
    static let None: UInt32 = 0
    static let Player: UInt32 = 0b1
    static let Bullet: UInt32 = 0b10
    static let Zombie: UInt32 = 0b100
    static let Wall: UInt32 = 0b1000
    static let Box: UInt32 = 0b10000
}
