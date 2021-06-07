import PlaygroundSupport
import SpriteKit
import Dispatch
import Foundation

public func scene6(){
    
    class GameScene: SKScene{
        
        let backgroundMusic = SKAudioNode(fileNamed: "adventure-sound.mpeg")
        
        override func sceneDidLoad() {
            super.sceneDidLoad()
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFill
            
            let river = SKSpriteNode(imageNamed: "scene 6.png")
            river.zPosition = 0
            
            self.addChild(river)
            backgroundSound()
            
        }
        
        private lazy var owl: SKSpriteNode = {
            let owl = SKSpriteNode(imageNamed: "owl 1.png")
            owl.position = CGPoint(x: -350, y: -50)
            owl.setScale(0.5)
            owl.zPosition = 2
            owl.name = "owl"
            return owl
        }()
        
        func animationOwl(){
            var owlTextures = [SKTexture]()
            for i in 1...14 {
                owlTextures.append(SKTexture(imageNamed: "smallOwl\(i)"))
            }
            let animationAction = SKAction.animate(with: owlTextures, timePerFrame: 0.4)
            let repeatAction = SKAction.repeatForever(animationAction)
            
            owl.run(repeatAction)
            
            owl.run(.repeatForever(.sequence([
                .move(to: .init(x: 0, y: -200), duration: 1.4),
                .move(to: .init(x: 350, y: -100), duration: 1.4),
                .move(to: .init(x: 0, y: -200), duration: 1.4),
                .move(to: .init(x: -350, y: -50), duration: 1.4)
            ])))
            
        }
        
        public func backgroundSound() {   
            backgroundMusic.run(SKAction.changeVolume(to: Float(0.08), duration: 0))
            backgroundMusic.run(.play())
            self.addChild(backgroundMusic)    
            
        }
        
        override func didMove(to view: SKView) {
            self.addChild(owl)
            animationOwl()
        }
        
    }
    
    var view1 = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 1325, height: 1999)))
    var scene1 = GameScene(size: view1.frame.size)
    view1.presentScene(scene1)
    PlaygroundPage.current.setLiveView(view1)
    
}
