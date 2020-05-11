//
//  Ball.swift
//  Ballz
//
//  Created by Christopher Grayston on 5/3/20.
//  Copyright © 2020 Christopher Grayston. All rights reserved.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    // MARK: - Properties
    private var touchBegan: CGPoint
    private var touchEnded: CGPoint
    
    var inMotion: Bool {
        get {
            guard let physicsBody = physicsBody else { return false }
            return !(physicsBody.velocity == CGVector(dx: 0, dy: 0))
        }
    }
  
    var dx: CGFloat {
        get {
            return touchBegan.x - touchEnded.x
        }
    }

    var dy: CGFloat {
        get {
            return touchBegan.y - touchEnded.y
        }
    }
    
    // MARK: - Init
    
    init() {
        touchEnded = CGPoint(x: 0, y: 0)
        touchBegan = CGPoint(x: 0, y: 0)
        
        
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ball Methods
    
    func reset() {
        guard let parent = self.parent else {
            return
        }
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.position = CGPoint(x: 0, y: parent.frame.minY + (self.frame.height / 2))
    }
    
    func setWith(touchBegan: CGPoint) {
        self.touchBegan = touchBegan
    }
    
    func fireWith(touchEnded: CGPoint) {
        self.touchEnded = touchEnded
        self.physicsBody?.applyImpulse(CGVector(dx: self.dx, dy: self.dy))
    }
    
    // MARK: - Setup
    
//    func setup() {
//        guard let parent = self.parent else {
//            return
//        }
//
//        self.position.y = parent.frame.minY
//        self.size.width = parent.frame.width * Constants.Multiplier.ballSizeMultiplier
//        self.size.height = parent.frame.width * Constants.Multiplier.ballSizeMultiplier
//    }
    
    func setupPhysicsBody() {
        // Set physics body properties
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.frame.width / 2,
                                                        self.frame.height / 2))
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = false
        physicsBody?.pinned = false
        physicsBody?.affectedByGravity = false
        
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.mass = 0.2
        
        physicsBody?.categoryBitMask = 1
        physicsBody?.collisionBitMask = 2
        physicsBody?.fieldBitMask = 0
        physicsBody?.contactTestBitMask = 0
    }
}
