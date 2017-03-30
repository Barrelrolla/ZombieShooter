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
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,2,0,2,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,0,0,2,0,2,0,0,0,0,0,0,2,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
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
    
    static func generateBackground(number: Int, scene: GameScene) {
        let variantRule: SKTileGroupRule
        if number == 1 {
            let variant1 = SKTexture(imageNamed: "tile_01")
            let variant2 = SKTexture(imageNamed: "tile_02")
            let variant3 = SKTexture(imageNamed: "tile_03")
            let variant4 = SKTexture(imageNamed: "tile_04")
            let var1def = SKTileDefinition(texture: variant1, size: variant1.size())
            let var2def = SKTileDefinition(texture: variant2, size: variant2.size())
            let var3def = SKTileDefinition(texture: variant3, size: variant3.size())
            let var4def = SKTileDefinition(texture: variant4, size: variant4.size())
            variantRule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [var1def, var2def, var3def, var4def])
        } else if number == 2 {
            let variant1 = SKTexture(imageNamed: "tile_07")
            let variant2 = SKTexture(imageNamed: "tile_08")
            let var1def = SKTileDefinition(texture: variant1, size: variant1.size())
            let var2def = SKTileDefinition(texture: variant2, size: variant2.size())
            variantRule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [var1def, var2def])
        } else if number == 3 {
            let variant1 = SKTexture(imageNamed: "tile_15")
            let variant2 = SKTexture(imageNamed: "tile_16")
            let var1def = SKTileDefinition(texture: variant1, size: variant1.size())
            let var2def = SKTileDefinition(texture: variant2, size: variant2.size())
            variantRule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [var1def, var2def])
        } else {
            let variant1 = SKTexture(imageNamed: "tile_19")
            let variant2 = SKTexture(imageNamed: "tile_20")
            let var1def = SKTileDefinition(texture: variant1, size: variant1.size())
            let var2def = SKTileDefinition(texture: variant2, size: variant2.size())
            variantRule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [var1def, var2def])
        }
        
        let group = SKTileGroup(rules: [variantRule])
        let set = SKTileSet(tileGroups: [group])
        let cols: Int
        let rows: Int
        if number == 1 {
            cols = level1[0].count - 1
            rows = level1.count - 1
        } else if number == 2 {
            cols = level2[0].count - 1
            rows = level2.count - 1
        } else {
            cols = level3[0].count - 1
            rows = level3.count - 1
        }
        
        if scene.childNode(withName: "tiles") != nil {
            scene.background.fill(with: group)
        } else {
            scene.background = SKTileMapNode(tileSet: set, columns: cols, rows: rows, tileSize: CGSize(width: 64, height: 64), fillWith: group)
            
            scene.background.zPosition = SpriteLayer.Background
            scene.background.anchorPoint = CGPoint(x: 0, y: 0)
            scene.background.lightingBitMask = 1
            scene.background.fill(with: group)
            scene.background.name = "tiles"
            scene.addChild(scene.background)
        }
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
                    tile.name = "map"
                    scene.addChild(tile)
                } else if (levelTemplate[row][col] == 2) {
                    let texture = SKTexture(imageNamed: "tile_129")
                    tile = BoxTile(texture: texture, color: SKColor.yellow, size: texture.size())
                    tile.position = CGPoint(x: x, y: y)
                    tile.name = "map"
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
