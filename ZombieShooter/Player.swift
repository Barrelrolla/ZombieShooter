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
    public var health: Double
    public var maxHealth: Double
    public var activeWeapon = 0
    public var weapons: [Weapon]
    public var moveSpeed:CGFloat
    
    init () {
        self.health = 10
        self.maxHealth = 10
        self.moveSpeed = 4
        self.weapons = [WeaponFactory.getWeapon(type: .Pistol)]
        self.pistolTexture = SKTexture(imageNamed: "survivor1_gun")
        self.machineGunTexture = SKTexture(imageNamed: "survivor1_silencer")
        self.reloadTexture = SKTexture(imageNamed: "survivor1_reload")
        super.init(texture: self.pistolTexture, color: SKColor.white, size: self.pistolTexture.size())
    }
    
    init(pistolTexture: SKTexture, machineGunTexture: SKTexture, reloadTexture: SKTexture, color: UIColor, size: CGSize, health: Double, moveSpeed: CGFloat, weapon: Weapon) {
        self.weapons = [weapon]
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
            if self.weapons[activeWeapon].ammo > 0 {
                var dx = vector.dx
                var dy = vector.dy
                let magnitude = sqrt(dx * dx + dy * dy)
                dx /= magnitude
                dy /= magnitude
                let newVector = CGVector(dx: 500*dx, dy: 500*dy)
                let weapon = self.weapons[activeWeapon]
                
                let shoot = SKAction(weapon.shoot(scene: scene, vector: newVector, x: self.position.x, y: self.position.y, zRotation: self.zRotation))
                let wait = SKAction.wait(forDuration: self.weapons[activeWeapon].shootRate)
                let deleteAction = SKAction(self.removeAction(forKey: "shooting"))
                let shootAndWait = SKAction.sequence([AudioPlayer.playShootSound(), shoot, wait, deleteAction])
                //let shooting = SKAction.repeatForever(shootAndWait)
                self.run(shootAndWait, withKey: "shooting")
                self.weapons[activeWeapon].ammo -= 1
                let ammo: String
                if weapon.totalAmmo < 100000 {
                    ammo = String(weapon.totalAmmo)
                } else {
                    ammo = "--"
                }
                scene.ammoLabel.text = "\(self.weapons[player.activeWeapon].ammo)/\(ammo)"
            } else {
                if self.weapons[activeWeapon].totalAmmo > 0 {
                    let weapon = self.weapons[activeWeapon]
                    self.texture = self.reloadTexture
                    let reload = SKAction.sequence([
                        AudioPlayer.playReloadSound(),
                        SKAction.wait(forDuration: weapon.reloadTime),
                        SKAction.run {
                            self.weapons[self.activeWeapon].reload()
                            if self.weapons[self.activeWeapon].weaponType == WeaponType.MachineGun {
                                self.texture = self.machineGunTexture
                            } else {
                                self.texture = self.pistolTexture
                            }
                            let ammo: String
                            if weapon.totalAmmo < 100000 {
                                ammo = String(weapon.totalAmmo)
                            } else {
                                ammo = "--"
                            }
                            scene.ammoLabel.text = "\(self.weapons[player.activeWeapon].ammo)/\(ammo)"
                        }
                        ])
                    self.run(reload, withKey: "reloading")
                } else {
                    self.weapons.remove(at: self.activeWeapon)
                    self.activeWeapon = 0
                    self.texture = pistolTexture
                    scene.updateArrows()
                }
            }
        }
    }
    
    func restoreHealth() {
        self.health += 10
        if self.health > self.maxHealth {
            self.health = self.maxHealth
        }
    }
    
    func addWeapon(weapon: Weapon) {
        if self.weapons.count < 2 {
            self.weapons.append(weapon)
            self.activeWeapon = self.weapons.count - 1
            if weapon.weaponType == WeaponType.MachineGun {
                self.texture = self.machineGunTexture
            } else {
                self.texture = self.pistolTexture
            }
        }
    }
    
    func switchWeapon(weapon: Int) {
        self.activeWeapon = weapon
        if weapon == 0 {
            self.texture = self.pistolTexture
        } else if weapon == 1 {
            self.texture = self.machineGunTexture
        }
    }
    
    func takeDamage(amount: Double, scene: GameScene) {
        if health > 0 {
            self.health -= amount
            scene.updateHealthBar()
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
        self.weapons = [WeaponFactory.getWeapon(type: .Pistol)]
        self.pistolTexture = SKTexture(imageNamed: "survivor1_gun")
        self.machineGunTexture = SKTexture(imageNamed: "survivor1_silencer")
        self.reloadTexture = SKTexture(imageNamed: "survivor1_reload")
        super.init(coder: aDecoder)
    }
}
