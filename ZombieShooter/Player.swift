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
    private var weapon: Weapon!
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.weapon = Weapon(ammo: 10, shootRate: 0.3)
    }
    
    func startShooting(scene: GameScene, vector: CGVector) {
        let currAction = self.action(forKey: "shooting")
        if (currAction == nil) {
            var dx = vector.dx
            var dy = vector.dy
            let magnitude = sqrt(dx * dx + dy * dy)
            dx /= magnitude
            dy /= magnitude
            let newVector = CGVector(dx: 500*dx, dy: 500*dy)
        
            let shoot = SKAction(self.weapon.shoot(scene: scene, vector: newVector, x: self.position.x, y: self.position.y, zRotation: self.zRotation))
            let wait = SKAction.wait(forDuration: self.weapon.shootRate)
            let deleteAction = SKAction(self.removeAction(forKey: "shooting"))
            let shootAndWait = SKAction.sequence([shoot, wait, deleteAction])
            //let shooting = SKAction.repeatForever(shootAndWait)
            self.run(shootAndWait, withKey: "shooting")
        }
    }
    
    func stopShooting() {
        self.removeAction(forKey: "shooting")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
