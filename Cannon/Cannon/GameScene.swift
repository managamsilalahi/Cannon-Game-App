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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // game elements that the scene interacts with programmatically
    private var secondsLabel: SKLabelNode! = nil
    private var cannon: Cannon! = nil
    
    // game state
    private var timeLeft: CFTimeInterval = 10.0
    private var elapsedTime: CFTimeInterval = 0.0
    private var previousTime: CFTimeInterval = 0.0
    private var targetsRemaining: Int = numberOfTargets
    
    
    
    // called when scene is presented
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.whiteColor()
        
        // helps determine game element speeds based on scene size
        var velocityMultiplier = self.size.width / self.size.height
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            velocityMultiplier = CGFloat(velocityMultiplier * 6.0)
        }
        
        
        // configure the physicsWorlds
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        
        // carete border for objects colliding with screen edges
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.friction = 0.0 // no friction
        self.physicsBody?.categoryBitMask = CollisionCategory.Wall
        self.physicsBody?.contactTestBitMask = CollisionCategory.Cannonball
        
        
        createLabels() // display labels at scene's top-left corner
        
        
        // create and attach Cannon
        cannon = Cannon(sceneSize: size, velocityMultiplier: velocityMultiplier)
        cannon.position = CGPointMake(0.0, self.frame.height / 2.0)
        self.addChild(cannon)
        
        
        // create and attach medium Blocker and start moving
        let blockerxPercent = CGFloat(0.5)
        let blockeryPercent = CGFloat(0.25)
        let blocker = Blocker(sceneSize: self.frame.size, blockerSize: BlockerSize.Medium)

        
        blocker.position = CGPointMake(self.frame.width * blockerxPercent, self.frame.height * blockeryPercent)
        self.addChild(blocker)
        blocker.startMoving(velocityMultiplier)
        
        
        //create and attach targets of random size and start moving
        let targetxPercent = CGFloat(0.6) // % across scene to 1st target
        var targetX = size.width * targetxPercent
        
        
        for i in 1 ... numberOfTargets {
            
            let target = Target(sceneSize: self.frame.size)
            target.position = CGPointMake(targetX, self.frame.height * 0.5)
            targetX += target.size.width + 5.0
            self.addChild(target)
            target.startMoving(velocityMultiplier)
            
        }
        
    }
    
    
    
    
    // create the text labels
    func createLabels() {
        
        // constants related to displaying text for time remaining
        let edgeDistance = CGFloat(20.0)
        let labelSpacing = CGFloat(5.0)
        let fontSize = CGFloat(16.0)
        
        // let configure "Time remaining: " label
        let timeRemainingLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeRemainingLabel.text = "Time remaining"
        timeRemainingLabel.fontSize = fontSize
        timeRemainingLabel.fontColor = SKColor.blackColor()
        timeRemainingLabel.horizontalAlignmentMode = .Left
        let y = self.frame.height - timeRemainingLabel.fontSize - edgeDistance
        timeRemainingLabel.position = CGPoint(x: edgeDistance, y: y)
        self.addChild(timeRemainingLabel)
        
        
        // configure label for displaying time remaining
        secondsLabel = SKLabelNode(fontNamed: "Chalkduster")
        secondsLabel.text = "0.0 seconds"
        secondsLabel.fontSize = fontSize
        secondsLabel.fontColor = SKColor.blackColor()
        secondsLabel.horizontalAlignmentMode = .Left
        let x = timeRemainingLabel.calculateAccumulatedFrame().width + edgeDistance + labelSpacing
        secondsLabel.position = CGPoint(x: x, y: y)
        self.addChild(secondsLabel)
        
    }
    
}
