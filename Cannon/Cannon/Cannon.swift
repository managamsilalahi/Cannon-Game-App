//
//  Cannon.swift
//  Cannon
//
//  Created by Admin on 4/28/16.
//  Copyright © 2016 Morra. All rights reserved.
//


// Defines the cannon and handles firing cannon balls
import AVFoundation
import SpriteKit

class Cannon: SKNode {

    // constants
    private let cannonSizePercent = CGFloat(0.15)
    private let cannonballSizePercent = CGFloat(0.075)
    private let cannonBarrelWidthPercent = CGFloat(0.075)
    private let cannonBarrelLengthPercent = CGFloat(0.15)
    private let cannonBallSpeed: CGFloat
    private let cannonBallSpeedMultiplier = CGFloat(0.25)
    private let barrelLength: CGFloat
    
    
    private var barrelAngle = CGFloat(0.0)
    private var cannonBall = SKSpriteNode()
    var cannonballOnScreen = false
    
    
    // initializes the Cannon, sizing it based on the scene's size
    init(sceneSize: CGSize, velocityMultiplier: CGFloat) {
        
        cannonBallSpeed = cannonBallSpeedMultiplier * velocityMultiplier
        barrelLength = sceneSize.height * cannonBarrelLengthPercent
        super.init()
        
        
        // configure cannon barrel
        let barrel = SKShapeNode(rectOfSize: CGSizeMake(barrelLength, sceneSize.height * cannonBarrelWidthPercent))
        barrel.fillColor = SKColor.blackColor()
        self.addChild(barrel)
        
        
        // configure cannon base
        let cannonBase = SKSpriteNode(imageNamed: "base")
        cannonBase.size = CGSizeMake(sceneSize.height * cannonSizePercent, sceneSize.height * cannonSizePercent)
        self.addChild(cannonBase)
        
        
        // position barrel based on cannonBase
        barrel.position = CGPointMake(cannonBase.size.width / 2.0, 0.0)
        
    }
    
    
    // not called, but required if subclass defines an init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // rotate cannon to user's touch point, then fire cannon ball
    func rotateToPointAndFire(point: CGPoint, scene: SKScene) {
        
        // calculate barrel rotation angle
        let deltaX = point.x
        let deltaY = point.y - self.position.y
        barrelAngle = CGFloat(atan2f(Float(deltaY), Float(deltaX)))
        
        // rotate the cannon barrel to touch point, then fire
        let rotateAction = SKAction.rotateToAngle(barrelAngle, duration: 0.25, shortestUnitArc: true)
        
        // perform rotate action, then call fireCannonball
        self.runAction(rotateAction) { 
            if !(self.cannonballOnScreen) {
                self.fireCannonball(scene)
            }
        }
        
    }
    
}
