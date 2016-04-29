//
//  GameOverScene.swift
//  Cannon
//
//  Created by Admin on 4/28/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    // configure GameOverScene
    
    init(size: CGSize, won: Bool, time: CFTimeInterval) {
        
        super.init(size: size)
        
    }
    
    
    // not called, but required if you override SKScene's init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
