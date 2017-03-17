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
    let player = SKSpriteNode(imageNamed: "survivor1_gun")
    
    override func sceneDidLoad() {
        let width = self.size.width
        let height = self.size.height
        var background = [SKSpriteNode]()
        
        //(imageNamed: "tile_01")
        var xPos: Int = 0
        var yPos: Int = 0
        repeat {
            yPos = 0
            repeat {
                let tile = SKSpriteNode(imageNamed: "tile_01")
                tile.position = CGPoint(x: xPos, y: yPos)
                tile.zPosition = 0
                background.append(tile)
                self.addChild(tile)
                yPos+=64
            } while yPos < Int(height)
            xPos+=64
        } while xPos < Int(width)
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        player.zPosition = 1
        self.addChild(player)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            let prevPos = t.previousLocation(in: self)
            let movedX = pos.x - prevPos.x
            let movedY = pos.y - prevPos.y
            
            player.position.x += movedX
            player.position.y += movedY
            self.touchMoved(toPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
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
        
        self.lastUpdateTime = currentTime
    }
}
