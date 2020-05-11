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
        static var blockSizeDivisor: CGFloat = 7.0
    }
    
    struct Colors {
        static var playArea = UIColor(white: 0.08, alpha: 1.0)
        static var background = UIColor(white: 0.15, alpha: 1.0)
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: -  Properties
    
    // Node Declaration
    var ball = Ball()
    var block = Block()
    var shotArrow = ShotArrow()
    var playArea = SKSpriteNode()
    
    // Variable Declaration
    var frameSize = CGRect.zero
    
    
    // MARK: - DidMove to create scenes contents
    override func didMove(to view: SKView) {
        // Set Delegate
        self.physicsWorld.contactDelegate = self
        
        // Set desired play area size
        frameSize = CGRect(x: self.frame.minX, y: self.frame.minY + (self.frame.height * Constants.Multiplier.safeAreaMarginMultiplier), width: self.frame.width, height: self.frame.height * Constants.Multiplier.yPositionMultiplier)
        
        // Setup
        setupPlayArea()
        setupBall()
        setupBlock()
        setupBorder()
        
        // Add children
        self.addChild(playArea)
        playArea.addChild(ball)
        playArea.addChild(block)
        playArea.addChild(shotArrow)

        // Set background color
        self.backgroundColor = Constants.Colors.background
    }

    // MARK: - Helper Methods
    
    func setupPlayArea() {
        playArea.position = CGPoint(x: frameSize.midX, y: frameSize.midY)
        playArea.size = CGSize(width: frameSize.width, height: frameSize.height)
        playArea.color = Constants.Colors.playArea
    }
    
    func setupBall() {
        ball.position.y = playArea.frame.minY
        ball.size.width = self.frame.width * Constants.Multiplier.ballSizeMultiplier
        ball.size.height = self.frame.width * Constants.Multiplier.ballSizeMultiplier
        ball.setupPhysicsBody()
    }
    
    func setupBlock() {
        block.position.y = self.playArea.frame.maxY * Constants.Multiplier.yPositionMultiplier
        block.position.x = self.frame.midX
        block.size.width = self.frame.width / Constants.Multiplier.blockSizeDivisor
        block.size.height = self.frame.width / Constants.Multiplier.blockSizeDivisor
        block.setupPhysicsBody()
    }
    
    func setupBorder() {
        let border = SKPhysicsBody(edgeLoopFrom: frameSize)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    // MARK: - Touches Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        // Reset ball velocity and position
        ball.reset()
        
        // Set initial touch
        shotArrow.setWith(touchBegan: location)
        
        // Set initial touch in ball object
        ball.setWith(touchBegan: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        // Guard against finger going above
        guard let initialTouch = shotArrow.initialTouch,
            initialTouch != location,
            initialTouch.y > location.y else {
                // Escape shot trajectory selection and reset arrow
                shotArrow.escapeShot()
                return
        }
        
        // Set touches ended and fire ball
        ball.fireWith(touchEnded: location)
        
        // Reset initial touch and shot arrow
        shotArrow.reset()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        // Guard against finger going above initial touch
        guard let initialTouch = shotArrow.initialTouch,
            initialTouch != location,
            initialTouch.y > location.y else {
                // Escape shot trajectory selection and reset arrow
                shotArrow.escapeShot()
                return
        }
        
        // Calculate and draw shot trajectory path
        shotArrow.drawShotArrowFrom(position: ball.position, withTouch: location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: - SKPhysicsContactDelegate Functions
    
    func didBegin(_ contact: SKPhysicsContact) {
        block.wasHit()
    }
}
