//
//  MachineGun.swift
//  ZombieShooter
//
//  Created by JT on 3/29/17.
//  Copyright © 2017 JT. All rights reserved.
//

import Foundation
import SpriteKit

class MachineGun: PowerUp {
    init(x: CGFloat, y: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "machineGun"), x: x, y: y)
    }
    
    override func executeEffect() {
        if player.weapons.count == 1 {
            player.addWeapon(weapon: WeaponFactory.getWeapon(type: .MachineGun))
        } else {
            player.weapons[1].getAmmo(amount: 300)
        }
        self.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
