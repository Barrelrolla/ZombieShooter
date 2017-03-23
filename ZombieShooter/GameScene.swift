//
//  GameScene.swift
//  ZombieShooter
//
//  Created by JT on 3/17/17.
//  Copyright © 2017 JT. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var lastUpdateTime : TimeInterval = 0
    private var isLeftStickActive = false
    private var isRightStickActive = false
    private var deltaX: CGFloat = 0
    private var deltaY: CGFloat = 0
    
    var player = PlayerFactory.getPlayer(type: PlayerType.Male)
    var gameScore = 0
    let scoreLabel = SKLabelNode(fontNamed: "FeastofFleshBB")
    let hasLighting = true
    let background: SKTileMapNode = LevelFactory.generateBackground()
    let leftStickRadius = SKSpriteNode(imageNamed: "transparentLight09")
    let leftStick = SKSpriteNode(imageNamed: "transparentLight49")
    let rightStickRadius = SKSpriteNode(imageNamed: "transparentLight09")
    let rightStick = SKSpriteNode(imageNamed: "transparentLight49")
    
    override func sceneDidLoad() {
        self.startGame()
    }
    
    func resetGame() {
        self.removeAllActions()
        self.camera?.removeAllChildren()
        self.removeAllChildren()
        gameScore = 0
        player = PlayerFactory.getPlayer(type: PlayerType.Male)
        self.startGame()
    }
    
    func startGame() {
        let width = self.size.width
        let height = self.size.height
        //self.backgroundColor = SKColor(red: 182/255, green: 223/255, blue: 249/255, alpha: 1)
        self.backgroundColor = SKColor.black
        self.physicsWorld.contactDelegate = self
        // var background = [SKSpriteNode]()
        
        background.zPosition = 0
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.lightingBitMask = 1
        self.addChild(background)
        
        LevelFactory.addLevel(number: 1, scene: self)
        
        player?.position = CGPoint(x: height / 2, y: width / 2)
        player?.zPosition = 2
        self.addChild(player!)
        /*
         let dot = SKShapeNode(circleOfRadius: 1)
         dot.fillColor = SKColor.red
         dot.strokeColor = SKColor.red
         dot.position = CGPoint(x: 30, y: -10)
         dot.zPosition = 5
         player?.addChild(dot)
         let texture = SKTexture(imageNamed: "obscurer2")
         let leftLightObscurer = SKSpriteNode(texture: texture)
         leftLightObscurer.anchorPoint = CGPoint(x: 0, y: 0)
         leftLightObscurer.position = CGPoint(x: -20, y: -20)
         leftLightObscurer.zPosition = 2
         leftLightObscurer.lightingBitMask = 1
         leftLightObscurer.shadowedBitMask = 1
         leftLightObscurer.shadowCastBitMask = 1
         leftLightObscurer.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
         leftLightObscurer.physicsBody?.affectedByGravity = false
         leftLightObscurer.physicsBody?.categoryBitMask = PhysicsCategories.None
         leftLightObscurer.physicsBody?.collisionBitMask = PhysicsCategories.None
         leftLightObscurer.alpha = 0.1
         player?.addChild(leftLightObscurer)
         let rightLightObscurer = SKSpriteNode(texture: texture)
         rightLightObscurer.anchorPoint = CGPoint(x: 0, y: 0)
         rightLightObscurer.position = CGPoint(x: -20, y: 20)
         rightLightObscurer.zPosition = 2
         rightLightObscurer.lightingBitMask = 1
         rightLightObscurer.shadowedBitMask = 1
         rightLightObscurer.shadowCastBitMask = 1
         rightLightObscurer.alpha = 0.1
         rightLightObscurer.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
         rightLightObscurer.physicsBody?.affectedByGravity = false
         rightLightObscurer.physicsBody?.categoryBitMask = PhysicsCategories.None
         rightLightObscurer.physicsBody?.collisionBitMask = PhysicsCategories.None
         rightLightObscurer.yScale = rightLightObscurer.yScale * -1
         player?.addChild(rightLightObscurer)
         */
        if hasLighting == true {
            let light = SKLightNode()
            light.ambientColor = SKColor.black
            light.lightColor = SKColor.white
            light.position = CGPoint(x: 0, y: 0)
            light.falloff = 1.3
            light.zPosition = 1
            player?.addChild(light)
        }
        
        
        let camera = SKCameraNode()
        self.camera = camera
        
        leftStickRadius.setScale(0.35)
        leftStickRadius.position = CGPoint(x: -120, y: -50)
        leftStickRadius.zPosition = 100
        leftStickRadius.alpha = 0.5
        camera.addChild(leftStickRadius)
        
        leftStick.setScale(0.25)
        leftStick.position = CGPoint(x: leftStickRadius.position.x, y: leftStickRadius.position.y)
        leftStick.zPosition = 101
        camera.addChild(leftStick)
        
        rightStickRadius.setScale(0.35)
        rightStickRadius.position = CGPoint(x: 120, y: -50)
        rightStickRadius.zPosition = 100
        rightStickRadius.alpha = 0.5
        camera.addChild(rightStickRadius)
        
        rightStick.setScale(0.25)
        rightStick.position = CGPoint(x: rightStickRadius.position.x, y: rightStickRadius.position.y)
        rightStick.zPosition = 101
        camera.addChild(rightStick)
        
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 15
        scoreLabel.color = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: -150, y: 70)
        scoreLabel.zPosition = 100
        camera.addChild(scoreLabel)
        
        camera.position = CGPoint(x: (player?.position.x)!, y: (player?.position.y)!)
        let zoomAction = SKAction.scale(to: 2.5, duration: 0)
        camera.run(zoomAction)
        self.addChild(camera)
        
        let spawnAction = SKAction.run(spawnZombie)
        let waitAction = SKAction.wait(forDuration: 3)
        let spawnSequence = SKAction.sequence([spawnAction, waitAction])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
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
            }
        } else if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Zombie {
            player?.takeDamage(amount: 1)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
                player?.zRotation = rightAngle
                player?.startShooting(scene: self, vector: rightVector)
                rightStick.position = CGPoint(x: pos.x, y: pos.y)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
                player?.zRotation = rightAngle
                player?.startShooting(scene: self, vector: rightVector)
            } else {
                if (isRightStickActive == true && pos.x > 0) {
                    rightStick.position = CGPoint(x: rightStickRadius.position.x - rightXDist, y: rightStickRadius.position.y + rightYDist)
                    player?.zRotation = rightAngle
                    player?.startShooting(scene: self, vector: rightVector)
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
        scoreLabel.text = "Score: \(gameScore)"
        if player != nil && player?.isAlive() == false {
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: 2),
                SKAction.run(resetGame)
            ]))
        }
        
        player?.position.x -= deltaX / 4
        player?.position.y -= deltaY / 4
        camera?.position = CGPoint(x: (player?.position.x)!, y: (player?.position.y)!)
        
        if (isRightStickActive) {
            let vector = CGVector(dx: rightStick.position.x - rightStickRadius.position.x, dy: rightStick.position.y - rightStickRadius.position.y)
            player?.startShooting(scene: self, vector: vector)
        }
        
        
        for child in self.children {
            if child.name == "zombie" {
                let zombie = child as! Zombie
                let moveAction = SKAction.move(to: (player?.position)!, duration: 2)
                zombie.run(moveAction)
                let vector = CGVector(dx: (player?.position.x)! - zombie.position.x, dy: (player?.position.y)! - zombie.position.y)
                let angle = atan2(vector.dy, vector.dx)
                zombie.zRotation = angle
            }
        }
        
        self.lastUpdateTime = currentTime
    }
}
