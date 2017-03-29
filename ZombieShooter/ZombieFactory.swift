//
//  ZombieFactory.swift
//  ZombieShooter
//
//  Created by JT on 3/22/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class ZombieFactory {
    static func getNewZombie() -> Zombie {
        let texture = SKTexture(imageNamed: "zoimbie1_hold")
        let type: ZombieType
        let rng = Int(RandomGenerator.random(min: 0, max: 3))
        if rng == 0 {
            type = ZombieType.Small
        } else if rng == 1 {
            type = ZombieType.Medium
        } else {
            type = ZombieType.Big
        }
        
        switch type {
        case .Small:
            return Zombie(texture: texture, health: 2, scale: CGSize(width: (texture.size().width / 1.25), height: (texture.size().height / 1.25)), moveSpeed: 2)
        case .Medium:
            return Zombie(texture: texture, health: 5, scale: CGSize(width: texture.size().width, height: texture.size().height), moveSpeed: 1.5)
        case .Big:
            return Zombie(texture: texture, health: 10, scale: CGSize(width: (texture.size().width * 1.5), height: (texture.size().height * 1.5)), moveSpeed: 1)
        }
    }
    
    static func getBoss() -> Zombie {
        let texture = SKTexture(imageNamed: "robot1_hold")
        return Zombie(texture: texture, health: 30, scale: CGSize(width: (texture.size().width * 2), height: (texture.size().height * 2)), moveSpeed: 1)
    }
}
