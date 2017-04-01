//
//  CharacterSelectScene.swift
//  ZombieShooter
//
//  Created by JT on 3/31/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterSelectScene: SKScene {
    let malePicture = SKSpriteNode(imageNamed: "survivor1_stand")
    let femalePicture = SKSpriteNode(imageNamed: "womanGreen_stand")
    let startLabel = SKLabelNode(fontNamed: Constants.FontName)
    let selectLabel = SKLabelNode(fontNamed: Constants.FontName)
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 62/255, green: 24/255, blue: 9/255, alpha: 1)
        
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gestureRecognizer:)))
        swipeRight.direction = .right
        self.view?.addGestureRecognizer(swipeRight)
        
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gestureRecognizer:)))
        swipeRight.direction = .left
        self.view?.addGestureRecognizer(swipeLeft)
        
        startLabel.text = "Start"
        startLabel.fontColor = SKColor.white
        startLabel.fontSize = 35
        startLabel.horizontalAlignmentMode = .center
        startLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 100)
        self.addChild(startLabel)
        
        selectLabel.text = "Select character:"
        selectLabel.fontColor = .white
        selectLabel.fontSize = 35
        selectLabel.horizontalAlignmentMode = .center
        selectLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) + 70)
        self.addChild(selectLabel)
        
        malePicture.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        malePicture.setScale(2)
        self.addChild(malePicture)
        
        femalePicture.position = CGPoint(x: (self.size.width / 2) + 100, y: self.size.height / 2)
        femalePicture.setScale(2)
        self.addChild(femalePicture)
        
        if activePlayer == .Female {
            malePicture.run(SKAction.moveTo(x: (self.size.width / 2) - 100, duration: 0))
            femalePicture.run(SKAction.moveTo(x: self.size.width / 2, duration: 0))
        }
    }
    
    func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.direction == .left {
            malePicture.run(SKAction.moveTo(x: (self.size.width / 2) - 100, duration: 0.1))
            femalePicture.run(SKAction.moveTo(x: self.size.width / 2, duration: 0.1))
            activePlayer = .Female
        } else if gestureRecognizer.direction == .right {
            malePicture.run(SKAction.moveTo(x: self.size.width / 2, duration: 0.1))
            femalePicture.run(SKAction.moveTo(x: (self.size.width / 2) + 100, duration: 0.1))
            activePlayer = .Male
        }
    }
    
    func changeScene() {
        gameScore = 0
        currLevel = 1
        currWave = 0
        self.view?.removeGestureRecognizer(swipeLeft)
        self.view?.removeGestureRecognizer(swipeRight)
        player = PlayerFactory.getPlayer(type: activePlayer)!
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
