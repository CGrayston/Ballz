//
//  ShotArrow.swift
//  Ballz
//
//  Created by Christopher Grayston on 5/10/20.
//  Copyright © 2020 Christopher Grayston. All rights reserved.
//

import SpriteKit

class ShotArrow: SKShapeNode {
    
    // MARK: - Properties
    var pathToDraw = CGMutablePath()
    var initialTouch: CGPoint?
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        strokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lineWidth = 5
        fillTexture = SKTexture(imageNamed: "arrow")
        fillColor = .white
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ShotArrow Methods
    
    func setWith(touchBegan: CGPoint) {
        self.initialTouch = touchBegan
        self.isHidden = false
    }
    
    func reset() {
        self.initialTouch = nil
        self.isHidden = true
        self.pathToDraw = CGMutablePath()
        self.path = nil
    }
    
    func escapeShot() {
        self.pathToDraw = CGMutablePath()
        self.path = pathToDraw
    }
    
    func drawShotArrowFrom(position: CGPoint, withTouch location: CGPoint) {
        guard let initialTouch = initialTouch else {
            return
        }
        
        let x = position.x + (initialTouch.x - location.x)
        let y = position.y + (initialTouch.y - location.y)
        let movedLocation = CGPoint(x: x, y: y)
        pathToDraw = CGMutablePath()
        pathToDraw.addLines(between: [position, movedLocation])
        self.path = pathToDraw
    }
}
