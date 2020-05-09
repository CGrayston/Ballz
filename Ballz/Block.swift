//
//  Block.swift
//  Ballz
//
//  Created by Christopher Grayston on 5/4/20.
//  Copyright © 2020 Christopher Grayston. All rights reserved.
//

import SpriteKit

enum BlockColors {
    case cyan
}

class Block: SKSpriteNode {
    
    // MARK: - Landing Pad
    var adjustedSize: CGSize? {
        didSet {
            setupPhysicsBody()
        }
    }
    
    // MARK: - Properties
    var hp: Int
    
    /* Cordinates
     *  x: 0 through 6
     *  y: 0 through 6
     *  Cordinate System: top left of screen is (0,0)
     */
    var cordinates: (x: Int, y: Int)
    
    // MARK: - Init
    init() {
        self.hp = 8
        self.cordinates = (0,0)
        super.init(texture: nil, color: UIColor.cyan, size: CGSize.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setupPhysicsBody() {
        guard let adjustedSize = adjustedSize else {
            fatalError("Wasn't able to pass screen size")
        }
        
        // Set physics body properties
        physicsBody = SKPhysicsBody(rectangleOf: adjustedSize)
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = false
        physicsBody?.pinned = true
        physicsBody?.affectedByGravity = false
        
        physicsBody?.friction = 0
        physicsBody?.restitution = 0
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.mass = 2.0
        
        physicsBody?.categoryBitMask = 2
        physicsBody?.collisionBitMask = 1
        physicsBody?.fieldBitMask = 0
        physicsBody?.contactTestBitMask = 1
    }
    
    // MARK: - Methods
    
    func randomCordinates() {
        // TODO:
    }
}
