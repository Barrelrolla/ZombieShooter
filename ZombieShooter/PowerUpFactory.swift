//
//  PowerUpFactory.swift
//  ZombieShooter
//
//  Created by JT on 3/29/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class PowerUpFactory {
    static func getPowerUp(type: PowerUpType, x: CGFloat, y: CGFloat) -> PowerUp {
        switch type {
        case .MachineGun:
            return MachineGun(x: x, y: y)
        case .Medkit:
            return MedKit(x: x, y: y)
        }
    }
}
