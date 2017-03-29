//
//  PlayerFactory.swift
//  ZombieShooter
//
//  Created by JT on 3/20/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerFactory {
    static func getPlayer(type: PlayerType) -> Player? {
        switch type {
        case .Male:
            return Player(pistolTexture: SKTexture(imageNamed: "survivor1_gun"), machineGunTexture: SKTexture(imageNamed: "survivor1_silencer"), reloadTexture: SKTexture(imageNamed: "survivor1_reload"), color: SKColor.blue, size: CGSize(width: 51, height: 43), health: 20, moveSpeed: 6, weapon: WeaponFactory.getWeapon(type: .Pistol))
        case .Female:
            return Player(pistolTexture: SKTexture(imageNamed: "womanGreen_gun"), machineGunTexture: SKTexture(imageNamed: "womanGreen_silencer"), reloadTexture: SKTexture(imageNamed: "womanGreen_reload"), color: SKColor.green, size: CGSize(width: 51, height: 43), health: 10, moveSpeed: 5, weapon: WeaponFactory.getWeapon(type: .Pistol))
        }
    }
}
