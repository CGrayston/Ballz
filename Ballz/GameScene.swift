//
//  GameScene.swift
//  Ballz
//
//  Created by Christopher Grayston on 5/3/20.
//  Copyright © 2020 Christopher Grayston. All rights reserved.
//

import SpriteKit
import GameplayKit

private struct BallConstants {
    static var yPositionMultiplier: CGFloat = 0.8
    static var sizeMultiplier: CGFloat = 0.05
}

class GameScene: SKScene {
    // Node Declaration
    var ball = Ball()
    
    
    // Variable Declaration
    
    override func didMove(to view: SKView) {
        // Setup ball
        setupBall()
        
        // Create border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        //ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
    }

    // MARK: - Helper Methods
    
    func setupBall() {
        // Create ball
        ball.position.y = self.frame.minY * BallConstants.yPositionMultiplier
        ball.size.width = self.frame.width * BallConstants.sizeMultiplier
        ball.size.height = self.frame.width * BallConstants.sizeMultiplier
        addChild(ball)
        ball.adjustedSize = ball.size
    }
    
    
    // MARK: - Touches Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Track where the touch began so we can make the arrow from the ball
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.position = CGPoint(x: 0, y: self.frame.minY * BallConstants.yPositionMultiplier)
        for touch in touches {
            // Reset ball velocity
            
            //print("Touch started: \(touch.location(in: self))")
            let touchLocation = touch.location(in: self)
            
            // Set touches began
            ball.touchesBegan = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //print("Touch ended: \(touch.location(in: self))")
            // Set touches ended
            let touchLocation = touch.location(in: self)
            ball.touchesEnded = touchLocation
            
            print("dx: \(ball.dx), dy: \(ball.dy)")
            
            ball.physicsBody?.applyImpulse(CGVector(dx: ball.dx, dy: ball.dy))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            print("Touch moved: \(touch.location(in: self))")
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
