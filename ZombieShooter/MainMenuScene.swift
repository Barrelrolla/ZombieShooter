//
//  MainMenuScene.swift
//  ZombieShooter
//
//  Created by JT on 3/24/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    let zombieLabel = SKLabelNode(fontNamed: Constants.FontName)
    let startLabel = SKLabelNode(fontNamed: Constants.FontName)
    let shooterLabel = SKLabelNode(fontNamed: Constants.FontName)

    override func didMove(to view: SKView) {
        zombieLabel.text = "Zombie"
        zombieLabel.color = SKColor.white
        zombieLabel.fontSize = 50
        zombieLabel.horizontalAlignmentMode = .center
        zombieLabel.position = CGPoint(x: -200, y: (self.size.height / 2) + 60)
        self.addChild(zombieLabel)
        
        shooterLabel.text = "Shooter"
        shooterLabel.color = SKColor.white
        shooterLabel.fontSize = 50
        shooterLabel.horizontalAlignmentMode = .center
        shooterLabel.position = CGPoint(x: self.size.width + 200, y: (self.size.height / 2) + 10)
        self.addChild(shooterLabel)
        
        startLabel.text = "Start"
        startLabel.color = SKColor.white
        startLabel.fontSize = 35
        startLabel.horizontalAlignmentMode = .center
        startLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 50)
        startLabel.run(SKAction.scale(to: 0, duration: 0))
        self.addChild(startLabel)
        
        let moveZombieAction = SKAction.run(moveZombieToCenter)
        let moveShooterAction = SKAction.run(moveShooterToCenter)
        let scaleStart = SKAction.run(scaleStartLabel)
        let sequence = SKAction.sequence([
            SKAction.wait(forDuration: 1),
            moveZombieAction,
            SKAction.wait(forDuration: 0.5),
            moveShooterAction,
            SKAction.wait(forDuration: 0.5),
            scaleStart
            ])
        self.run(sequence)
    }
    
    func scaleStartLabel() {
        startLabel.run(SKAction.scale(to: 1, duration: 0.1))
    }
    
    func moveZombieToCenter() {
        moveToCenter(label: zombieLabel)
    }
    
    func moveShooterToCenter() {
        moveToCenter(label: shooterLabel)
    }
    
    func moveToCenter(label: SKLabelNode) {
        let moveToCenterAction = SKAction.moveTo(x: self.size.width / 2, duration: 0.2)
        label.run(moveToCenterAction)
    }
    
    func changeScene() {
        let newScene = GameScene(size: CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
        newScene.scaleMode = .aspectFill
        self.view?.presentScene(newScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if startLabel.contains(t.location(in: self)) {
                changeScene()
            }
        }
    }
}
