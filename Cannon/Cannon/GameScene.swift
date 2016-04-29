//
//  GameScene.swift
//  Cannon
//
//  Created by Admin on 4/29/16.
//  Copyright © 2016 Morra. All rights reserved.
//

// creates the scene, detects touches and responds to collisions
import AVFoundation
import SpriteKit

// used to identify objects for collision detection
struct CollisionCategory {
    
    static let Blocker: UInt32 = 1
    static let Target: UInt32 = 1 << 1 // 2
    static let Cannonball: UInt32 = 1 << 2 // 4
    static let Wall: UInt32 = 1 << 3 // 8
    
}

// global because no type constants in Swift classes yet
private let numberOfTargets = 9

class GameScene: SKScene {
    
    // game elements that the scene interacts with programmatically
    private var secondsLabel: SKLabelNode! = nil
    private var cannon: Cannon! = nil
    
    // game state
    private var timeLeft: CFTimeInterval = 10.0
    private var elapsedTime: CFTimeInterval = 0.0
    private var previousTime: CFTimeInterval = 0.0
    private var targetsRemaining: Int = numberOfTargets
    
}
