//
//  GameScene.swift
//  ZombieShooter
//
//  Created by JT on 3/17/17.
//  Copyright © 2017 JT. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var lastUpdateTime : TimeInterval = 0
    private var isLeftStickActive = false
    private var isRightStickActive = false
    private var deltaX: CGFloat = 0
    private var deltaY: CGFloat = 0
    
    let player = PlayerFactory.getPlayer(type: PlayerType.Male)
    let leftStickRadius = SKSpriteNode(imageNamed: "transparentLight09")
    let leftStick = SKSpriteNode(imageNamed: "transparentLight49")
    let rightStickRadius = SKSpriteNode(imageNamed: "transparentLight09")
    let rightStick = SKSpriteNode(imageNamed: "transparentLight49")
    
    override func sceneDidLoad() {
        let width = self.size.width
        let height = self.size.height
        var background = [SKSpriteNode]()
        
        var xPos: Int = 0
        var yPos: Int = 0
        var rand = 0
        var tile: SKSpriteNode
        repeat {
            yPos = 0
            repeat {
                if (rand % 2 == 0) {
                    tile = SKSpriteNode(imageNamed: "tile_01")
                } else if (rand % 3 == 0) {
                    tile = SKSpriteNode(imageNamed: "tile_02")
                } else if (rand % 4 == 0) {
                    tile = SKSpriteNode(imageNamed: "tile_03")
                } else {
                    tile = SKSpriteNode(imageNamed: "tile_04")
                }
                
                rand+=1
                tile.position = CGPoint(x: xPos, y: yPos)
                tile.zPosition = 0
                background.append(tile)
                self.addChild(tile)
                yPos+=64
            } while yPos < Int(width)
            xPos+=64
        } while xPos < Int(height)
        
        player?.position = CGPoint(x: height / 2, y: width / 2)
        player?.zPosition = 2
        self.addChild(player!)
        
        let camera = SKCameraNode()
        self.camera = camera
        
        leftStickRadius.setScale(0.35)
        leftStickRadius.position = CGPoint(x: -120, y: -50)
        leftStickRadius.zPosition = 100
        camera.addChild(leftStickRadius)
        
        leftStick.setScale(0.25)
        leftStick.position = CGPoint(x: leftStickRadius.position.x, y: leftStickRadius.position.y)
        leftStick.zPosition = 101
        camera.addChild(leftStick)
        
        rightStickRadius.setScale(0.35)
        rightStickRadius.position = CGPoint(x: 120, y: -50)
        rightStickRadius.zPosition = 100
        camera.addChild(rightStickRadius)
        
        rightStick.setScale(0.25)
        rightStick.position = CGPoint(x: rightStickRadius.position.x, y: rightStickRadius.position.y)
        rightStick.zPosition = 101
        camera.addChild(rightStick)
        
        camera.position = CGPoint(x: (player?.position.x)!, y: (player?.position.y)!)
        let zoomAction = SKAction.scale(to: 2, duration: 0)
        camera.run(zoomAction)
        self.addChild(camera)
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
                player?.stopShooting()
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
        player?.position.x -= deltaX / 4
        player?.position.y -= deltaY / 4
        camera?.position = CGPoint(x: (player?.position.x)!, y: (player?.position.y)!)
        
        if (isRightStickActive) {
            let vector = CGVector(dx: rightStick.position.x - rightStickRadius.position.x, dy: rightStick.position.y - rightStickRadius.position.y)
            player?.startShooting(scene: self, vector: vector)
        }
        
        self.lastUpdateTime = currentTime
    }
}
