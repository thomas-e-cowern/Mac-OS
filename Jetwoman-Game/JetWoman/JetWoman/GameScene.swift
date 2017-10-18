//
//  GameScene.swift
//  JetWoman
//
//  Created by Thomas Cowern New on 9/25/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let jetWomanCategory = 2
    let lowerLimitCategory = 3
    
    var currentCharacter : String?
    var currentKeyCode : Int?
    
    
    let character = ["A", "B", "C", "D", "E", "1", "2", "3", "4", "5"]
    let keyCodes = [0, 11, 8, 2, 14, 18, 19, 20, 21, 23]
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var jetWoman : SKSpriteNode?
    private var startButton : SKSpriteNode?
    private var scoreLabel : SKLabelNode?
    private var highScoreLabel : SKLabelNode?
    private var crash : SKNode?
    
    var score = 0
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.jetWoman = self.childNode(withName: "jetWoman") as? SKSpriteNode
        self.startButton = self.childNode(withName: "startButton") as? SKSpriteNode
        self.scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        self.highScoreLabel = self.childNode(withName: "highScore") as? SKLabelNode
        self.crash = self.childNode(withName: "crash")
        
        
        
        let highscore = UserDefaults.standard.integer(forKey: "highscore")
        highScoreLabel?.text = "High: \(highscore)"
        scoreLabel?.text = "Score: \(score)"
        
    }
    
    func startGame() {
        
        if let jetWoman = self.jetWoman {
            
            crash?.alpha = 0.03
            jetWoman.position = CGPoint(x: 0, y: 100)
            jetWoman.physicsBody?.pinned = false
            scoreLabel?.text = "Score: \(score)"
            
        }
        
    }
    
    func updateHighScore() {
        
        let highscore = UserDefaults.standard.integer(forKey: "highscore")
        highScoreLabel?.text = "High: \(highscore)"
    }
    
    func chooseNextKey() {
        
        let count = UInt32(character.count)
        let randomIndex = Int(arc4random_uniform(count))
        currentCharacter = character[randomIndex]
        currentKeyCode = keyCodes[randomIndex]
        if label == self.label {
            label?.text = currentCharacter
            label?.alpha = 1.0
            
        }
        
    }
    
    override func mouseDown(with event: NSEvent) {
        
        let point = event.location(in: self)
        let nodesAtPoint = nodes(at: point)
        for node in nodesAtPoint {
            if node.name == "startButton" {
                if let jetWoman = self.jetWoman {
                    print("Start")
                    jetWoman.physicsBody?.pinned = false
                    jetWoman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
                    node.removeFromParent()
                    //                startButton?.isHidden = true
                    score = 0
                    chooseNextKey()
                    startGame()
                    
                }
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        
        if let theKeycode = currentKeyCode {
            
            switch event.keyCode {
            case UInt16(theKeycode):
                if let jetWoman = self.jetWoman {
                    
                    jetWoman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: (200 )))
                    score += 1
                    scoreLabel?.text = "Score: \(score)"
                    chooseNextKey()
                    
                }
            default:
                print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            }
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == 3 && contact.bodyB.collisionBitMask == 3 {
            
            print("New Collision")
        }
        
        if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 3 {
            print("Collision")
            
            if let startButton = self.startButton {
                if startButton.parent != self {
                    addChild(startButton)
                    currentCharacter = nil
                    currentKeyCode = nil
                    if label == self.label {
                        label?.text = currentCharacter
                        label?.alpha = 0.0
                    }
                    crash?.alpha = 1.0
                    //Check if current score is high score
                    
                    let highscore = UserDefaults.standard.integer(forKey: "highscore")
                    if score > highscore{
                        UserDefaults.standard.set(score, forKey: "highscore")
                        UserDefaults.standard.synchronize()
                        if let highScoreLabel = highScoreLabel {
                            highScoreLabel.text = "High: \(score)"
                        }
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
