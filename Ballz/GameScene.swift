//
//  GameScene.swift
//  Ballz
//
//  Created by Christopher Grayston on 5/3/20.
//  Copyright © 2020 Christopher Grayston. All rights reserved.
//

import SpriteKit
import GameplayKit

private struct Constants {
    struct Multiplier {
        static var yPositionMultiplier: CGFloat = 0.8
        static var safeAreaMarginMultiplier = (1 - Constants.Multiplier.yPositionMultiplier) / 2
        static var ballSizeMultiplier: CGFloat = 0.045
    }
    
    struct Colors {
        static var playArea = UIColor(white: 0.08, alpha: 1.0)
        static var background = UIColor(white: 1.0, alpha: 1.0)
    }
}

class GameScene: SKScene {
    // Node Declaration
    var ball = Ball()
    var playArea = SKSpriteNode()
    
    // Variable Declaration
    var frameSize = CGRect.zero
    
    override func didMove(to view: SKView) {
        // Set desired play area size
        frameSize = CGRect(x: self.frame.minX, y: self.frame.minY + (self.frame.height * Constants.Multiplier.safeAreaMarginMultiplier), width: self.frame.width, height: self.frame.height * Constants.Multiplier.yPositionMultiplier)
        
        // Setup play area
        setupPlayArea()
        
        // Setup ball
        setupBall()
        
        // Setup border
        setupBorder()
        
        // Add to scene
        self.addChild(ball)
        self.addChild(playArea)
        self.backgroundColor = UIColor.red
    }

    // MARK: - Helper Methods
    
    func setupPlayArea() {
        playArea.position = CGPoint(x: frameSize.midX, y: frameSize.midY)
        playArea.size = CGSize(width: frameSize.width, height: frameSize.height)
        playArea.color = UIColor.blue
    }
    
    func setupBall() {
        ball.position.y = self.frame.minY * Constants.Multiplier.yPositionMultiplier
        ball.size.width = self.frame.width * Constants.Multiplier.ballSizeMultiplier
        ball.size.height = self.frame.width * Constants.Multiplier.ballSizeMultiplier
        ball.adjustedSize = ball.size
    }
    
    func setupBorder() {
        let border = SKPhysicsBody(edgeLoopFrom: frameSize)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    // MARK: - Touches Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Track where the touch began so we can make the arrow from the ball
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.position = CGPoint(x: 0, y: self.frame.minY * Constants.Multiplier.yPositionMultiplier)
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
