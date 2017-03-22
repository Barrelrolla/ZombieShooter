//
//  LevelFactory.swift
//  ZombieShooter
//
//  Created by JT on 3/21/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class LevelFactory {
    static let level1 = [
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ]
    
    static func addLevel(number: Int, scene: GameScene) {
        if (number == 1) {
            let level = level1
            var row = 0
            var col = 0
            var x = 0
            var y = 0
            
            repeat {
                col = 0
                x = 0
                repeat {
                    
                    let tile: SKSpriteNode
                    
                    if (level[row][col] == 1) {
                        let texture = SKTexture(imageNamed: "tile_169")
                        tile = WallTile(texture: texture, color: SKColor.black, size: texture.size())
                        tile.position = CGPoint(x: x, y: y)
                        scene.addChild(tile)
                    } else {
                        let rng = RandomGenerator.random(min: 1, max: 4)
                        let textureName = "tile_0" + String(describing: rng)
                        let texture = SKTexture(imageNamed: textureName)
                        tile = GroundTile(texture: texture, color: SKColor.green, size: texture.size())
                        tile.position = CGPoint(x: x, y: y)
                        scene.addChild(tile)
                    }
                    
                    x+=64
                    col+=1
                }
                while col < level[row].count
                
                y+=64
                row+=1
            } while row < level.count
        }
    }
}
