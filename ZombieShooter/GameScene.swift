//
//  GameScene.swift
//  ZombieShooter
//
//  Created by JT on 3/17/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AudioToolbox

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var lastUpdateTime : TimeInterval = 0
    private var isLeftStickActive = false
    private var isRightStickActive = false
    private var deltaX: CGFloat = 0
    private var deltaY: CGFloat = 0
    
    var enemyCount = 0
    var isGameOver = false
    var background = SKTileMapNode()
    var zombiesInCurrWave = 0
    var waveStarted = false
    let scoreLabel = SKLabelNode(fontNamed: Constants.FontName)
    let zombiesLabel = SKLabelNode(fontNamed: Constants.FontName)
    let waveLabel = SKLabelNode(fontNamed: Constants.FontName)
    let levelLabel = SKLabelNode(fontNamed: Constants.FontName)
    let ammoLabel = SKLabelNode(fontNamed: Constants.FontName)
    let healthLabel = SKLabelNode(fontNamed: Constants.FontName)
    let leftStickRadius = SKSpriteNode(imageNamed: "transparentLight09")
    let leftStick = SKSpriteNode(imageNamed: "transparentLight49")
    let rightStickRadius = SKSpriteNode(imageNamed: "transparentLight09")
    let rightStick = SKSpriteNode(imageNamed: "transparentLight49")
    let statusBar = SKSpriteNode(imageNamed: "statusBar")
    let weaponStatus = SKSpriteNode(imageNamed: "bullet")
    let leftArrow = SKSpriteNode(imageNamed: "arrowBeige_left")
    let rightArrow = SKSpriteNode(imageNamed: "arrowBeige_right")
    
    override func sceneDidLoad() {
        self.startGame()
    }
    
    func startGame() {
        let width = self.size.width
        let height = self.size.height
        self.backgroundColor = SKColor.black
        self.physicsWorld.contactDelegate = self
        
        self.addChild(background)
        LevelFactory.generateBackground(number: currLevel, scene: self)
        LevelFactory.addLevel(number: currLevel, scene: self)
        
        player.position = CGPoint(x: height / 2, y: width / 2)
        if player.parent == nil {
            self.addChild(player)
        }
        
        /*
         let dot = SKShapeNode(circleOfRadius: 1)
         dot.fillColor = SKColor.red
         dot.strokeColor = SKColor.red
         dot.position = CGPoint(x: 30, y: -10)
         dot.zPosition = 5
         player?.addChild(dot)
        */
        
        if hasLighting == true && player.childNode(withName: "flashlight") == nil {
            let light = SKLightNode()
            light.name = "flashlight"
            light.ambientColor = SKColor.black
            light.lightColor = SKColor.white
            light.position = CGPoint(x: 0, y: 0)
            light.falloff = 1.3
            light.zPosition = SpriteLayer.Bullets
            player.addChild(light)
        }
        
        
        let camera = SKCameraNode()
        self.camera = camera
        
        leftStickRadius.setScale(0.40)
        leftStickRadius.position = CGPoint(x: -120, y: -50)
        leftStickRadius.zPosition = SpriteLayer.UILower
        leftStickRadius.alpha = 0.5
        camera.addChild(leftStickRadius)
        
        leftStick.setScale(0.30)
        leftStick.position = CGPoint(x: leftStickRadius.position.x, y: leftStickRadius.position.y)
        leftStick.zPosition = SpriteLayer.UIUpper
        camera.addChild(leftStick)
        
        rightStickRadius.setScale(0.40)
        rightStickRadius.position = CGPoint(x: 120, y: -50)
        rightStickRadius.zPosition = SpriteLayer.UILower
        rightStickRadius.alpha = 0.5
        camera.addChild(rightStickRadius)
        
        rightStick.setScale(0.30)
        rightStick.position = CGPoint(x: rightStickRadius.position.x, y: rightStickRadius.position.y)
        rightStick.zPosition = SpriteLayer.UIUpper
        camera.addChild(rightStick)
        
        statusBar.setScale(0.5)
        statusBar.position = CGPoint(x: 0, y: -70)
        statusBar.zPosition = SpriteLayer.UILower
        camera.addChild(statusBar)
        
        leftArrow.setScale(0.5)
        leftArrow.position = CGPoint(x: -60, y: -70)
        leftArrow.zPosition = SpriteLayer.UILower
        camera.addChild(leftArrow)
        
        rightArrow.setScale(0.5)
        rightArrow.position = CGPoint(x: 60, y: -70)
        rightArrow.zPosition = SpriteLayer.UILower
        camera.addChild(rightArrow)
        
        weaponStatus.setScale(0.5)
        weaponStatus.position = CGPoint(x: 0, y: -70)
        weaponStatus.zPosition = SpriteLayer.UIUpper
        camera.addChild(weaponStatus)
        
        ammoLabel.text = "\(player.weapons[player.activeWeapon].ammo)/--"
        ammoLabel.fontSize = 10
        ammoLabel.fontColor = .black
        ammoLabel.horizontalAlignmentMode = .right
        ammoLabel.position = CGPoint(x: 40, y: -75)
        ammoLabel.zPosition = SpriteLayer.UIUpper
        camera.addChild(ammoLabel)
        
        healthLabel.text = "HP: \(Int(player.health))"
        healthLabel.fontSize = 10
        healthLabel.fontColor = .black
        healthLabel.horizontalAlignmentMode = .left
        healthLabel.position = CGPoint(x: -40, y: -75)
        healthLabel.zPosition = SpriteLayer.UIUpper
        camera.addChild(healthLabel)
        
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 15
        scoreLabel.fontColor = .white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: -150, y: 70)
        scoreLabel.zPosition = SpriteLayer.UIUpper
        camera.addChild(scoreLabel)
        
        zombiesLabel.text = ""
        zombiesLabel.fontSize = 15
        zombiesLabel.fontColor = .white
        zombiesLabel.horizontalAlignmentMode = .right
        zombiesLabel.position = CGPoint(x: 150, y: 70)
        zombiesLabel.zPosition = SpriteLayer.UIUpper
        camera.addChild(zombiesLabel)
        
        levelLabel.text = ""
        levelLabel.fontSize = 24
        levelLabel.fontColor = .white
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.position = CGPoint(x: 0, y: 45)
        levelLabel.zPosition = SpriteLayer.UIUpper
        levelLabel.run(SKAction.scale(to: 0, duration: 0))
        camera.addChild(levelLabel)
        
        waveLabel.text = ""
        waveLabel.fontSize = 24
        waveLabel.fontColor = .white
        waveLabel.horizontalAlignmentMode = .center
        waveLabel.position = CGPoint(x: 0, y: 20)
        waveLabel.zPosition = SpriteLayer.UIUpper
        waveLabel.run(SKAction.scale(to: 0, duration: 0))
        camera.addChild(waveLabel)
        
        camera.position = CGPoint(x: player.position.x, y: player.position.y)
        let zoomAction = SKAction.scale(to: 2.5, duration: 0)
        camera.run(zoomAction)
        self.addChild(camera)
        
        levelLabel.text = "Level \(currLevel)"
        let resizeAction = SKAction.sequence([
                SKAction.scale(to: 1, duration: 0.1),
                SKAction.wait(forDuration: 2),
                SKAction.scale(to: 0, duration: 0.1),
                SKAction.run {
                self.levelLabel.text = ""
            }
            ])
        levelLabel.run(resizeAction)
        startNewWave()
    }
    
    func updateHealthBar() {
        healthLabel.text = "HP: \(Int(player.health))"
    }
    
    func startNewWave() {
        currWave += 1
        if (currWave == 3) {
            self.run(SKAction.sequence([
                    SKAction.wait(forDuration: 5),
                    SKAction.run {
                        let boss = ZombieFactory.getBoss(healthModifier: currLevel)
                        boss.position.x = player.position.x * -1
                        boss.position.y = player.position.y * -1
                        self.addChild(boss)
                }
            ]))
        }
        
        if currWave == 4 {
            currWave = 0
            currLevel += 1
            
            let newScene = GameScene(size: self.size)
            player.move(toParent: newScene)
            newScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(newScene, transition: transition)
        }
        
        waveLabel.text = "Wave \(currWave)"
        let resizeAction = SKAction.sequence([
            SKAction.scale(to: 1, duration: 0.1),
            SKAction.wait(forDuration: 2),
            SKAction.scale(to: 0, duration: 0.1),
            SKAction.run {
                self.waveLabel.text = ""
            }
            ])
        waveLabel.run(resizeAction)
        
        var zombieCount = currWave * 10
        zombieCount *= currLevel
        if currWave == 3 {
            zombieCount /= 3
            zombiesInCurrWave = zombieCount
            zombiesInCurrWave += 1
        } else {
            zombiesInCurrWave = zombieCount
        }
        waveStarted = true
        zombiesLabel.text = "Zombies Left: \(zombiesInCurrWave)"
        let waitAction = SKAction.wait(forDuration: 2)
        let spawnZombies = SKAction.run {
            for _ in 0..<currLevel {
                self.spawnZombie()
            }
        }
        let spawnSequence = SKAction.sequence([spawnZombies, waitAction])
        let spawnWave = SKAction.repeat(spawnSequence, count: zombieCount / currLevel)
        self.run(spawnWave)
    }
    
    func gameOver() {
        isGameOver = true
        leftStick.removeFromParent()
        leftStickRadius.removeFromParent()
        rightStick.removeFromParent()
        rightStickRadius.removeFromParent()
        let redLight = SKLightNode()
        redLight.ambientColor = SKColor.red
        redLight.lightColor = SKColor.red
        redLight.position = CGPoint(x: background.mapSize.height - background.tileSize.height, y: background.mapSize.width - background.tileSize.width)
        redLight.falloff = 1.3
        redLight.zPosition = SpriteLayer.Walls
        self.addChild(redLight)
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.run(changeScene)
        ]))
    }
    
    func changeScene() {
        let newScene = GameOverScene(size: UIScreen.main.bounds.size)
        newScene.scaleMode = .fill
        let transition = SKTransition.crossFade(withDuration: 1)
        self.view?.presentScene(newScene, transition: transition)
    }
    
    func spawnZombie() {
        let zombie = ZombieFactory.getNewZombie()
        let rng = Int(RandomGenerator.random(min: 0, max: 3))
        if rng == 0 {
            let newrng = RandomGenerator.random(min: 0, max: background.mapSize.height)
            zombie.position = CGPoint(x: 0, y: newrng)
        } else if rng == 1 {
            let newrng = RandomGenerator.random(min: 0, max: background.mapSize.height)
            zombie.position = CGPoint(x: background.mapSize.width, y: newrng)
        } else if rng == 2 {
            let newrng = RandomGenerator.random(min: 0, max: background.mapSize.width)
            zombie.position = CGPoint(x: newrng, y: 0)
        } else {
            let newrng = RandomGenerator.random(min: 0, max: background.mapSize.width)
            zombie.position = CGPoint(x: newrng, y: background.mapSize.height)
        }
        
        self.addChild(zombie)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Wall {
            body1.node?.removeFromParent()
        } else if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Zombie {
            if body2.node != nil {
                let zombie = body2.node as! Zombie
                zombie.takeDamage(amount: 1, scene: self)
                body1.node?.removeFromParent()
                
                var blood = SKSpriteNode()
                var bloodFrames = [SKTexture]()
                let bloodAtlas = SKTextureAtlas(named: "blood")
                let numberOfImages = bloodAtlas.textureNames.count
                for index in 1...numberOfImages {
                    let textureName = "blood\(index)"
                    bloodFrames.append(bloodAtlas.textureNamed(textureName))
                }
                
                let firstFrame = bloodFrames[0]
                blood = SKSpriteNode(texture: firstFrame)
                blood.position = contact.contactPoint
                blood.zRotation = zombie.zRotation
                blood.zPosition = SpriteLayer.BackgroundTextures
                blood.size = CGSize(width: 60, height: 60)
                blood.lightingBitMask = 1
                
                self.addChild(blood)
                blood.run(SKAction.sequence([
                    SKAction.animate(with: bloodFrames, timePerFrame: 0.1, resize: false, restore: false),
                    SKAction.run {
                        blood.removeFromParent()
                        
                    }
                ]))
                
            }
            
        } else if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Zombie {
            if player.children.count > 0 {
                let light = player.childNode(withName: "flashlight") as! SKLightNode
                let becomeRed = SKAction.run {
                    light.lightColor = SKColor.orange
                }
                let wait = SKAction.wait(forDuration: 0.2)
                let becomeWhite = SKAction.run {
                    light.lightColor = .white
                }
                let vibrate = SKAction.run {
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                }
                let sequence = SKAction.sequence([becomeRed, vibrate, wait, becomeWhite])
                player.run(sequence)
            }

            player.takeDamage(amount: 1, scene: self)
        } else if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.PowerUp {
            if body2.node != nil {
                let powerup = body2.node as! PowerUp
                powerup.executeEffect()
                updateHealthBar()
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver == false {
            for t in touches {
                let pos = t.location(in: self.camera!)
                if leftStickRadius.contains(pos) {
                    isLeftStickActive = true
                    leftStick.position = CGPoint(x: pos.x, y: pos.y)
                    deltaX = leftStickRadius.position.x - leftStick.position.x
                    deltaY = leftStickRadius.position.y - leftStick.position.y
                } else if rightStickRadius.contains(pos) {
                    isRightStickActive = true
                    let rightVector = CGVector(dx: pos.x - rightStickRadius.position.x, dy: pos.y - rightStickRadius.position.y)
                    let rightAngle = atan2(rightVector.dy, rightVector.dx)
                    player.zRotation = rightAngle
                    player.startShooting(scene: self, vector: rightVector)
                    rightStick.position = CGPoint(x: pos.x, y: pos.y)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver == false {
            for t in touches {
                let pos = t.location(in: self.camera!)
                
                let leftVector = CGVector(dx: pos.x - leftStickRadius.position.x, dy: pos.y - leftStickRadius.position.y)
                let leftAngle = atan2(leftVector.dy,leftVector.dx)
                let leftLength: CGFloat = leftStickRadius.frame.size.height / 2
                
                let leftXDist:CGFloat = sin(leftAngle - 1.57079633) * leftLength
                let leftYDist:CGFloat = cos(leftAngle - 1.57079633) * leftLength
                
                let rightVector = CGVector(dx: pos.x - rightStickRadius.position.x, dy: pos.y - rightStickRadius.position.y)
                let rightAngle = atan2(rightVector.dy, rightVector.dx)
                let rightLength: CGFloat = rightStickRadius.frame.size.height / 2
                
                let rightXDist:CGFloat = sin(rightAngle - 1.57079633) * rightLength
                let rightYDist:CGFloat = cos(rightAngle - 1.57079633) * rightLength
                
                if leftStickRadius.contains(pos) {
                    leftStick.position = pos
                    deltaX = leftStickRadius.position.x - leftStick.position.x
                    deltaY = leftStickRadius.position.y - leftStick.position.y
                } else {
                    if (isLeftStickActive == true && pos.x < 0) {
                        leftStick.position = CGPoint(x: leftStickRadius.position.x - leftXDist, y: leftStickRadius.position.y + leftYDist)
                        deltaX = leftStickRadius.position.x - leftStick.position.x
                        deltaY = leftStickRadius.position.y - leftStick.position.y
                    }
                }
                
                if rightStickRadius.contains(pos) {
                    rightStick.position = pos
                    player.zRotation = rightAngle
                    player.startShooting(scene: self, vector: rightVector)
                } else {
                    if (isRightStickActive == true && pos.x > 0) {
                        rightStick.position = CGPoint(x: rightStickRadius.position.x - rightXDist, y: rightStickRadius.position.y + rightYDist)
                        player.zRotation = rightAngle
                        player.startShooting(scene: self, vector: rightVector)
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.previousLocation(in: self.camera!)
            if (pos.x < 0) {
                isLeftStickActive = false
                deltaX = 0
                deltaY = 0
                let moveBackAction = SKAction.move(to: CGPoint(x: leftStickRadius.position.x, y: leftStickRadius.position.y), duration: 0.1)
                leftStick.run(moveBackAction)
            } else if pos.x > 0 {
                isRightStickActive = false
                let moveBackAction = SKAction.move(to: CGPoint(x: rightStickRadius.position.x, y: rightStickRadius.position.y), duration: 0.1)
                rightStick.run(moveBackAction)
                //player?.stopShooting()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        // let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        camera?.position = CGPoint(x: player.position.x, y: player.position.y)
        if isGameOver == false {
            player.position.x -= deltaX / player.moveSpeed
            player.position.y -= deltaY / player.moveSpeed
            
            if (isRightStickActive) {
                let vector = CGVector(dx: rightStick.position.x - rightStickRadius.position.x, dy: rightStick.position.y - rightStickRadius.position.y)
                player.startShooting(scene: self, vector: vector)
            }
        }
        
        for child in self.children {
            if child.name == "zombie" {
                let zombie = child as! Zombie
                zombie.moveTowardPlayer(player: player)
            }
        }
        
        if waveStarted == true && zombiesInCurrWave == 0 {
            waveStarted = false
            let wait = SKAction.wait(forDuration: 5)
            let startWave = SKAction.run(startNewWave)
            let sequence = SKAction.sequence([wait, startWave])
            self.run(sequence)
        }
        
        self.lastUpdateTime = currentTime
    }
}
