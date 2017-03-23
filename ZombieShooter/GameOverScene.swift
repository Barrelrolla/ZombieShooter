//
//  GameOverScene.swift
//  ZombieShooter
//
//  Created by JT on 3/24/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    let scoreTextLabel = SKLabelNode(fontNamed: Constants.FontName)
    let scoreLabel = SKLabelNode(fontNamed: Constants.FontName)
    let highScoreTextLabel = SKLabelNode(fontNamed: Constants.FontName)
    let highScoreLabel = SKLabelNode(fontNamed: Constants.FontName)
    let retryLabel = SKLabelNode(fontNamed: Constants.FontName)
    override func didMove(to view: SKView) {
        
        let defaults = UserDefaults()
        var highscore = defaults.integer(forKey: "HighScore")
        if gameScore > highscore {
            highscore = gameScore
            defaults.set(highscore, forKey: "HighScore")
        }
        
        scoreTextLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreTextLabel.text = "Final Score:"
        scoreTextLabel.color = SKColor.white
        scoreTextLabel.fontSize = 30
        scoreTextLabel.position = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height / 2) + 60)
        self.addChild(scoreTextLabel)
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLabel.text = "\(gameScore)"
        scoreLabel.color = SKColor.white
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height / 2) + 30)
        self.addChild(scoreLabel)
        
        highScoreTextLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        highScoreTextLabel.text = "Highscore:"
        highScoreTextLabel.color = SKColor.white
        highScoreTextLabel.fontSize = 30
        highScoreTextLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.addChild(highScoreTextLabel)
        
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        highScoreLabel.text = "\(highscore)"
        highScoreLabel.color = SKColor.white
        highScoreLabel.fontSize = 30
        highScoreLabel.position = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height / 2) - 30)
        self.addChild(highScoreLabel)
        
        self.run(SKAction.sequence([
                SKAction.run(addRetryButton),
                SKAction.wait(forDuration: 1)
            ]))
    }
    
    func addRetryButton() {
        retryLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        retryLabel.text = "Try Again"
        retryLabel.color = SKColor.white
        retryLabel.fontSize = 40
        retryLabel.position = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height / 2) - 80)
        retryLabel.run(SKAction.scale(to: 0, duration: 0))
        self.addChild(retryLabel)
        retryLabel.run(SKAction.scale(to: 1, duration: 0.2))
    }
    
    func changeScene() {
        let newScene = GameScene(size: CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
        newScene.scaleMode = .aspectFill
        self.view?.presentScene(newScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if retryLabel.contains(t.location(in: self)) {
                changeScene()
            }
        }
    }
}
