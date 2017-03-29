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
    private let pistolTexture: SKTexture
    private let machineGunTexture: SKTexture
    private let reloadTexture: SKTexture
    private var activeWeapon = 0
    private var health: Int
    private var maxHealth: Int
    private var weapon: [Weapon]
    public var moveSpeed:CGFloat
    
    init(pistolTexture: SKTexture, machineGunTexture: SKTexture, reloadTexture: SKTexture, color: UIColor, size: CGSize, health: Int, moveSpeed: CGFloat, weapon: Weapon) {
        self.weapon = [weapon]
        self.health = health
        self.maxHealth = health
        self.moveSpeed = moveSpeed
        self.pistolTexture = pistolTexture
        self.machineGunTexture = machineGunTexture
        self.reloadTexture = reloadTexture
        super.init(texture: pistolTexture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(texture: pistolTexture, size: pistolTexture.size())
        self.zPosition = SpriteLayer.Characters
        self.lightingBitMask = 1
        self.shadowCastBitMask = 1
        self.shadowedBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Player
        self.physicsBody?.collisionBitMask = PhysicsCategories.Wall | PhysicsCategories.Zombie | PhysicsCategories.Box
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Zombie | PhysicsCategories.PowerUp
    }
    
    func startShooting(scene: GameScene, vector: CGVector) {
        let shootAction = self.action(forKey: "shooting")
        let reloadAction = self.action(forKey: "reloading")
        if (shootAction == nil && reloadAction == nil) {
            if self.weapon[activeWeapon].ammo > 0 {
                var dx = vector.dx
                var dy = vector.dy
                let magnitude = sqrt(dx * dx + dy * dy)
                dx /= magnitude
                dy /= magnitude
                let newVector = CGVector(dx: 500*dx, dy: 500*dy)
                let weapon = self.weapon[activeWeapon]
                
                let shoot = SKAction(weapon.shoot(scene: scene, vector: newVector, x: self.position.x, y: self.position.y, zRotation: self.zRotation))
                let wait = SKAction.wait(forDuration: self.weapon[activeWeapon].shootRate)
                let deleteAction = SKAction(self.removeAction(forKey: "shooting"))
                let shootAndWait = SKAction.sequence([shoot, wait, deleteAction])
                //let shooting = SKAction.repeatForever(shootAndWait)
                self.run(shootAndWait, withKey: "shooting")
                self.weapon[activeWeapon].ammo -= 1
            } else {
                let weapon = self.weapon[activeWeapon]
                self.texture = self.reloadTexture
                let reload = SKAction.sequence([
                    SKAction.wait(forDuration: weapon.reloadTime),
                    SKAction.run {
                        self.weapon[self.activeWeapon].reload()
                        if self.weapon[self.activeWeapon].weaponType == WeaponType.MachineGun {
                            self.texture = self.machineGunTexture
                        } else {
                            self.texture = self.pistolTexture
                        }
                    }
                ])
                self.run(reload, withKey: "reloading")
            }
        }
    }
    
    func restoreHealth() {
        self.health = self.maxHealth
    }
    
    func addWeapon(weapon: Weapon) {
        self.weapon.append(weapon)
        self.activeWeapon = self.weapon.count - 1
        if weapon.weaponType == WeaponType.MachineGun {
            self.texture = self.machineGunTexture
        } else {
            self.texture = self.pistolTexture
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
        self.maxHealth = 10
        self.moveSpeed = 4
        self.weapon = [WeaponFactory.getWeapon(type: .Pistol)]
        self.pistolTexture = SKTexture(imageNamed: "survivor1_gun")
        self.machineGunTexture = SKTexture(imageNamed: "survivor1_silencer")
        self.reloadTexture = SKTexture(imageNamed: "survivor1_reload")
        super.init(coder: aDecoder)
    }
}
