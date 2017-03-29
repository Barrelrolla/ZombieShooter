//
//  Zombie.swift
//  ZombieShooter
//
//  Created by JT on 3/22/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class Zombie : SKSpriteNode {
    private var health : Int
    private let points: Int
    private let moveSpeed: CGFloat
    
    init(texture: SKTexture!, health: Int, scale: CGSize, moveSpeed: CGFloat) {
        self.moveSpeed = moveSpeed
        self.health = health
        self.points = (health / 2) * 100
        super.init(texture: texture, color: SKColor.red, size: texture.size())
        self.name = "zombie"
        self.scale(to: scale)
        self.zPosition = SpriteLayer.Characters
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.lightingBitMask = 1
        self.shadowCastBitMask = 1
        self.shadowedBitMask = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Zombie
        self.physicsBody?.collisionBitMask = PhysicsCategories.Player | PhysicsCategories.Box | PhysicsCategories.Zombie
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
    }
    
    func takeDamage(amount: Int, scene: GameScene) {
        health -= amount
        if health <= 0 {
            gameScore += points
            scene.scoreLabel.text = "Score: \(gameScore)"
            let scaleUp = SKAction.scale(to: 1.1, duration: 0.2)
            let scaleDown = SKAction.scale(to: 1, duration: 0.2)
            let scaleSeq = SKAction.sequence([scaleUp, scaleDown])
            scene.scoreLabel.run(scaleSeq)
            scene.zombiesInCurrWave -= 1
            scene.zombiesLabel.text = "Zombies Left: \(scene.zombiesInCurrWave)"
            
            var blood = SKSpriteNode()
            var bloodFrames = [SKTexture]()
            let bloodAtlas = SKTextureAtlas(named: "blood_d")
            let numberOfImages = bloodAtlas.textureNames.count
            for index in 1...numberOfImages {
                let textureName = "blood_d_000\(index)"
                bloodFrames.append(bloodAtlas.textureNamed(textureName))
            }
            
            let firstFrame = bloodFrames[0]
            blood = SKSpriteNode(texture: firstFrame)
            blood.position = self.position
            blood.zRotation = self.zRotation
            blood.zPosition = SpriteLayer.BackgroundTextures
            blood.size.width = self.size.width * 2
            blood.size.height = self.size.height * 2
            blood.lightingBitMask = 1
            
            scene.addChild(blood)
            blood.run(SKAction.sequence([
                SKAction.animate(with: bloodFrames, timePerFrame: 0.1, resize: false, restore: false),
                SKAction.run {
                    blood.removeFromParent()
                    
                }
                ]))
            
            self.removeFromParent()
        }
    }
    
    func moveTowardPlayer(player: Player) {
        let dx = player.position.x - self.position.x
        let dy = player.position.y - self.position.y
        let angle = atan2(dy, dx)
        self.zRotation = angle
        
        let vx = cos(angle) * moveSpeed
        let vy = sin(angle) * moveSpeed
        self.position.x += vx
        self.position.y += vy
        }
    
    required init?(coder aDecoder: NSCoder) {
        self.health = 1
        self.points = 100
        self.moveSpeed = 2
        super.init(coder: aDecoder)
    }
}
