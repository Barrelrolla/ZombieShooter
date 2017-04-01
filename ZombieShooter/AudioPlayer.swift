//
//  AudioPlayer.swift
//  ZombieShooter
//
//  Created by JT on 4/1/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class AudioPlayer {
    static var musicPlayer = AVAudioPlayer()
    
    static func stopMusic() {
        musicPlayer = AVAudioPlayer()
    }
    
    static func stopMusicWithFade() {
        if hasSound == true && musicPlayer.isPlaying {
            musicPlayer.setVolume(0, fadeDuration: 2)
        }
    }
    
    static func playMenuMusic() {
        if hasSound == true {
            if let url = Bundle.main.url(forResource: "menuMusic", withExtension: "wav") {
                musicPlayer = try! AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.volume = 1
                musicPlayer.play()
            }
        }
    }
    
    static func playBGMusic() {
        if hasSound == true {
            if let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "wav") {
                musicPlayer = try! AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.volume = 0.5
                musicPlayer.play()
            }
        }
    }
    
    static func playSwooshSound() -> SKAction {
        if hasSound == true {
            return swooshSound
        } else {
            return SKAction.wait(forDuration: 0)
        }
    }
    
    static func playShootSound() -> SKAction {
        if hasSound == true {
            return shootSound
        } else {
            return SKAction.wait(forDuration: 0)
        }
    }
    
    static func playReloadSound() -> SKAction {
        if hasSound == true {
            return reloadSound
        } else {
            return SKAction.wait(forDuration: 0)
        }
    }
    
    static func playHitSound() -> SKAction {
        if hasSound == true {
            return hitSound
        } else {
            return SKAction.wait(forDuration: 0)
        }
    }
    
    static func playSplatSound() -> SKAction {
        if hasSound == true {
            return splatSound
        } else {
            return SKAction.wait(forDuration: 0)
        }
    }
    
    static func playEatSound() -> SKAction {
        if hasSound == true {
            return eatSound
        } else {
            return SKAction.wait(forDuration: 0)
        }
    }
}
