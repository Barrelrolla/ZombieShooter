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
    private var health: Int = 10
    private var weapon: Weapon!
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.weapon = Weapon(ammo: 10, shootRate: 0.3)
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.lightingBitMask = 1
        self.shadowCastBitMask = 1
        self.shadowedBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Player
        self.physicsBody?.collisionBitMask = PhysicsCategories.Wall | PhysicsCategories.Zombie
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Zombie
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
    
    func takeDamage(amount: Int) {
        self.health -= amount
        if health <= 0 {
            self.removeAllChildren()
            self.removeFromParent()
        }
    }
    
    func isAlive() -> Bool {
        if self.health <= 0 {
            return false
        } else {
            return true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
