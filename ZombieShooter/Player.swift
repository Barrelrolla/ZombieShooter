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
    private var health: Int
    private var weapon: Weapon
    public var moveSpeed:CGFloat
    
    init(texture: SKTexture, color: UIColor, size: CGSize, health: Int, moveSpeed: CGFloat, weapon: Weapon) {
        self.weapon = weapon
        self.health = health
        self.moveSpeed = moveSpeed
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.zPosition = SpriteLayer.Characters
        self.lightingBitMask = 1
        self.shadowCastBitMask = 1
        self.shadowedBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Player
        self.physicsBody?.collisionBitMask = PhysicsCategories.Wall | PhysicsCategories.Zombie | PhysicsCategories.Box
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
    
    func takeDamage(amount: Int, scene: GameScene) {
        if health > 0 {
            self.health -= amount
            if health <= 0 {
                self.removeAllActions()
                self.removeAllChildren()
                scene.gameOver()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.health = 10
        self.moveSpeed = 4
        self.weapon = WeaponFactory.getWeapon(type: .Pistol)
        super.init(coder: aDecoder)
    }
}
