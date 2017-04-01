//
//  Globals.swift
//  ZombieShooter
//
//  Created by JT on 3/30/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

var gameScore = 0
var currLevel = 1
var currWave = 0
var activePlayer = PlayerType.Male
var player = Player()
var hasLighting = true
var hasSound = true
let swooshSound = SKAction.playSoundFileNamed("swooshSound.wav", waitForCompletion: false)
let shootSound = SKAction.playSoundFileNamed("shotSound.wav", waitForCompletion: false)
let reloadSound = SKAction.playSoundFileNamed("reloadSound.wav", waitForCompletion: false)
let hitSound = SKAction.playSoundFileNamed("hitSound", waitForCompletion: false)
let splatSound = SKAction.playSoundFileNamed("splatSound", waitForCompletion: false)
let eatSound = SKAction.playSoundFileNamed("eatSound", waitForCompletion: false)
