//
//  MainMenuScene.swift
//  ZombieShooter
//
//  Created by JT on 3/24/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit
import AVFoundation

class MainMenuScene: SKScene, GKGameCenterControllerDelegate {
    let zombieLabel = SKLabelNode(fontNamed: Constants.FontName)
    let startLabel = SKLabelNode(fontNamed: Constants.FontName)
    let shooterLabel = SKLabelNode(fontNamed: Constants.FontName)
    let soundButton = SKSpriteNode(imageNamed: "musicOn")
    let lightButton = SKSpriteNode(imageNamed: "contrast")
    let leaderboardButton = SKSpriteNode(imageNamed:"leaderboardsComplex")
    let defaults = UserDefaults()

    override func didMove(to view: SKView) {
        //authPlayer()
        self.backgroundColor = SKColor(red: 62/255, green: 24/255, blue: 9/255, alpha: 1)
        
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
        
        startLabel.text = "Play"
        startLabel.color = SKColor.white
        startLabel.fontSize = 35
        startLabel.horizontalAlignmentMode = .center
        startLabel.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 50)
        startLabel.run(SKAction.scale(to: 0, duration: 0))
        self.addChild(startLabel)
        
        if hasSound == false {
            soundButton.texture = SKTexture(imageNamed: "musicOff")
        }
        soundButton.position = CGPoint(x: (self.size.width / 2) + 80, y: (self.size.height / 2) - 100)
        soundButton.run(SKAction.scale(to: 0, duration: 0))
        self.addChild(soundButton)
        
        if hasLighting == false {
            lightButton.zRotation += CGFloat(M_PI/4.0) * 4
        }
        lightButton.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 100)
        lightButton.run(SKAction.scale(to: 0, duration: 0))
        lightButton.alpha = 0.2
        self.addChild(lightButton)
        
        leaderboardButton.position = CGPoint(x: (self.size.width / 2) - 80, y: (self.size.height / 2) - 100)
        leaderboardButton.run(SKAction.scale(to: 0, duration: 0))
        leaderboardButton.alpha = 0.1
        self.addChild(leaderboardButton)
        
        let moveZombieAction = SKAction.run(moveZombieToCenter)
        let moveShooterAction = SKAction.run(moveShooterToCenter)
        let scaleStart = SKAction.run(scaleStartLabel)
        let scaleButtonsAction = SKAction.run(scaleButtons)
        let sequence = SKAction.sequence([
            SKAction.wait(forDuration: 1),
            AudioPlayer.playSwooshSound(),
            moveZombieAction,
            SKAction.wait(forDuration: 0.5),
            AudioPlayer.playSwooshSound(),
            moveShooterAction,
            SKAction.wait(forDuration: 0.5),
            SKAction.run {
                AudioPlayer.playMenuMusic()
            },
            scaleStart,
            SKAction.wait(forDuration: 0.5),
            scaleButtonsAction
            ])
        self.run(sequence)
    }
    
    func scaleStartLabel() {
        startLabel.run(SKAction.scale(to: 1, duration: 0.1))
    }
    
    func scaleButtons() {
        soundButton.run(SKAction.scale(to: 1, duration: 0.1))
        lightButton.run(SKAction.scale(to: 1, duration: 0.1))
        leaderboardButton.run(SKAction.scale(to: 1, duration: 0.1))
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
        let newScene = CharacterSelectScene(size: self.size)
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
    
    func showLeaderBoard() {
        let viewController = self.view?.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        viewController?.present(viewController!, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if startLabel.contains(t.location(in: self)) {
                changeScene()
            } else if soundButton.contains(t.location(in: self)) {
                hasSound = !hasSound
                defaults.set(hasSound, forKey: "sound")
                if hasSound == true {
                    soundButton.texture = SKTexture(imageNamed: "musicOn")
                    AudioPlayer.playMenuMusic()
                } else {
                    soundButton.texture = SKTexture(imageNamed: "musicOff")
                    AudioPlayer.stopMusic()
                }
            } else if lightButton.contains(t.location(in: self)) {
                hasLighting = !hasLighting
                defaults.set(hasLighting, forKey: "light")
                if hasLighting == true {
                    lightButton.zRotation += CGFloat(M_PI/4.0) * 4
                } else {
                    lightButton.zRotation -= CGFloat(M_PI/4.0) * 4
                }
            } else if leaderboardButton.contains(t.location(in: self)) {
                //showLeaderBoard()
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
