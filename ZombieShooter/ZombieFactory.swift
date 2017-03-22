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
        return Zombie(texture: texture, health: 10, scale: CGSize(width: texture.size().width, height: texture.size().height))
    }
}
