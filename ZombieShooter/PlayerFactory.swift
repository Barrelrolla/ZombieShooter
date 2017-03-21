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
            return Player(texture: SKTexture(imageNamed: "survivor1_gun"), color: SKColor.blue, size: CGSize(width: 51, height: 43))
        case .Female:
            return Player(texture: SKTexture(imageNamed: "survivor1_gun"), color: SKColor.blue, size: CGSize(width: 51, height: 43))
        }
    }
}
