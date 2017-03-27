//
//  BulletFactory.swift
//  ZombieShooter
//
//  Created by JT on 3/27/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class BulletFactory {
    static func getBullet(x: CGFloat, y: CGFloat, rotation: CGFloat) -> Bullet {
        let bullet = Bullet(texture: SKTexture(imageNamed: "bullet"), color: SKColor.yellow, size: CGSize(width:19, height: 10))
        bullet.position = CGPoint(x: x, y: y)
        bullet.zRotation = rotation
        bullet.setScale(0.5)
        return bullet
    }
}
