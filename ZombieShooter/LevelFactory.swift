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
        [1,0,0,2,0,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,2,0,2,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,2,0,2,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ]
    static let level2 = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,2,0,2,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,2,0,2,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ]
    static let level3 = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,2,0,2,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,2,0,2,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ]
    
    static func generateBackground() -> SKTileMapNode {
        let variant1 = SKTexture(imageNamed: "tile_01")
        let var1def = SKTileDefinition(texture: variant1, size: variant1.size())
        let variant2 = SKTexture(imageNamed: "tile_02")
        let var2def = SKTileDefinition(texture: variant2, size: variant2.size())
        let variant3 = SKTexture(imageNamed: "tile_03")
        let var3def = SKTileDefinition(texture: variant3, size: variant3.size())
        let variant4 = SKTexture(imageNamed: "tile_04")
        let var4def = SKTileDefinition(texture: variant4, size: variant4.size())
        let variantRule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [var1def, var2def, var3def, var4def])
        let group = SKTileGroup(rules: [variantRule])
        let set = SKTileSet(tileGroups: [group])
        let map = SKTileMapNode(tileSet: set, columns: level1[0].count, rows: level1.count, tileSize: CGSize(width: 64, height: 64), fillWith: group)
        map.fill(with: group)
        return map
    }
    
    static func addLevel(number: Int, scene: GameScene) {
        var row = 0
        var col = 0
        var x = 0
        var y = 0
        let levelTemplate: [[Int]]
        
        if number == 1 {
            levelTemplate = level1
        } else if number == 2 {
            levelTemplate = level2
        } else {
            levelTemplate = level3
        }
            
        repeat {
            col = 0
            x = 0
            repeat {
                let tile: SKSpriteNode
                    
                if (levelTemplate[row][col] == 1) {
                    let texture = SKTexture(imageNamed: "tile_169")
                    tile = WallTile(texture: texture, color: SKColor.black, size: texture.size())
                    tile.position = CGPoint(x: x, y: y)
                    scene.addChild(tile)
                } else if (levelTemplate[row][col] == 2) {
                    let texture = SKTexture(imageNamed: "tile_129")
                    tile = BoxTile(texture: texture, color: SKColor.yellow, size: texture.size())
                    tile.position = CGPoint(x: x, y: y)
                    scene.addChild(tile)
                }
                    
                x+=64
                col+=1
            }
            while col < levelTemplate[row].count
                
            y+=64
            row+=1
        } while row < levelTemplate.count
    }
}
