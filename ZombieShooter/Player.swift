//
//  Player.swift
//  ZombieShooter
//
//  Created by JT on 3/20/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode {
    private var ammo: Int = 100
    private var weapon: Int = 1
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
