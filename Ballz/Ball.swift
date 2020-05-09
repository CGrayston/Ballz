//
//  Ball.swift
//  Ballz
//
//  Created by Christopher Grayston on 5/3/20.
//  Copyright © 2020 Christopher Grayston. All rights reserved.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    // MARK: - Landing Pad
    var adjustedSize: CGSize? {
        didSet {
            setupPhysicsBody()
        }
    }
    
    // MARK: - Properties
    var touchesBegan: CGPoint
    
    var touchesEnded: CGPoint
    
    var dx: CGFloat {
        get {
            return touchesBegan.x - touchesEnded.x
        }
    }
    
    var dy: CGFloat {
        get {
            return (touchesBegan.y - touchesEnded.y)
        }
    }
    
    // MARK: - Init
    
    init() {
        touchesEnded = CGPoint(x: 0, y: 0)
        touchesBegan = CGPoint(x: 0, y: 0)
        
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        //setup()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // MARK: - Setup
    func setupPhysicsBody() {
        guard let adjustedSize = adjustedSize else {
            fatalError("Wasn't able to pass screen size")
        }
        
        // Set physics body properties
        physicsBody = SKPhysicsBody(circleOfRadius: max(adjustedSize.width / 2,
        adjustedSize.height / 2))
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
