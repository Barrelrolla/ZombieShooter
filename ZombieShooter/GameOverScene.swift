//
//  GameOverScene.swift
//  ZombieShooter
//
//  Created by JT on 3/24/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class GameOverScene: SKScene, GKGameCenterControllerDelegate {
    let scoreTextLabel = SKLabelNode(fontNamed: Constants.FontName)
    let scoreLabel = SKLabelNode(fontNamed: Constants.FontName)
    let highScoreTextLabel = SKLabelNode(fontNamed: Constants.FontName)
    let highScoreLabel = SKLabelNode(fontNamed: Constants.FontName)
    let retryLabel = SKLabelNode(fontNamed: Constants.FontName)
    let menuLabel = SKLabelNode(fontNamed: Constants.FontName)
    
    override func didMove(to view: SKView) {
        //authPlayer()
        self.backgroundColor = SKColor(red: 62/255, green: 24/255, blue: 9/255, alpha: 1)
        
        let defaults = UserDefaults()
        var highscore = defaults.integer(forKey: "HighScore")
        if gameScore > highscore {
            highscore = gameScore
            defaults.set(highscore, forKey: "HighScore")
            //saveHighScore(number: highscore)
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
                SKAction.wait(forDuration: 0.5),
                SKAction.run(addMenuButton)
            ]))
    }
    
    func addMenuButton() {
        menuLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        menuLabel.text = "Back to Menu"
        menuLabel.color = SKColor.white
        menuLabel.fontSize = 20
        menuLabel.position = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height / 2) - 120)
        menuLabel.run(SKAction.scale(to: 0, duration: 0))
        self.addChild(menuLabel)
        menuLabel.run(SKAction.scale(to: 1, duration: 0.2))
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
    
    func newGame() {        
        gameScore = 0
        currLevel = 1
        currWave = 0
        player = PlayerFactory.getPlayer(type: activePlayer)!
        let newScene = GameScene(size: CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
        newScene.scaleMode = .aspectFill
        self.view?.presentScene(newScene)
    }
    
    func mainMenu() {
        let newScene = MainMenuScene(size: UIScreen.main.bounds.size)
        newScene.scaleMode = .fill
        self.view?.presentScene(newScene)
    }
    
    func authPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                self.view?.window?.rootViewController?.present(view!, animated: true, completion: nil)
            }
        }
    }
    
    func saveHighScore(number: Int) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "High")
            scoreReporter.value = Int64(gameScore)
            let scoreArray:[GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if retryLabel.contains(t.location(in: self)) {
                newGame()
            } else if menuLabel.contains(t.location(in: self)) {
                mainMenu()
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
