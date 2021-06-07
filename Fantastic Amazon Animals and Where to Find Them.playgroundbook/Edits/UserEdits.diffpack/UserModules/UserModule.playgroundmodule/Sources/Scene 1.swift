import PlaygroundSupport
import SpriteKit
import Dispatch
import Foundation

public func scene1(){
    
    class GameScene: SKScene{
        
        let backgroundMusic = SKAudioNode(fileNamed: "adventure-sound.mpeg")
        let startSound = SKAudioNode(fileNamed: "startSound.wav")
        var nextPage: SKButtonNode?
        
        override func sceneDidLoad() {
            super.sceneDidLoad()
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFill
            
            let river = SKSpriteNode(imageNamed: "scene 3.png")
            river.zPosition = 0
            
            self.addChild(river)
            backgroundSound()
            createStartButton()
            
        }
        
        private lazy var owl: SKSpriteNode = {
            let owl = SKSpriteNode(imageNamed: "owl 1.png")
            owl.position = CGPoint(x: -350, y: -50)
            owl.setScale(0.5)
            owl.zPosition = 2
            owl.name = "owl"
            return owl
        }()
        
        var buttonStartImage: SKSpriteNode = {
            let imageNextPage = SKSpriteNode(imageNamed: "startButton.png")
            imageNextPage.position = CGPoint(x: 0, y: 375)
            imageNextPage.zPosition = 5
            imageNextPage.setScale(1)
            return imageNextPage
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
        public func createStartButton(){
            DispatchQueue.main.asyncAfter(deadline: .now()){ [self] in
                nextPage = SKButtonNode(image: buttonStartImage, label: SKLabelNode()){
                    startSoundFunc()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
                        PlaygroundPage.current.navigateTo(page: .next)
                    }
                }
                self.addChild(self.nextPage!)
            }
        }
        
        public func startSoundFunc() {   
            startSound.run(SKAction.changeVolume(to: Float(0.4), duration: 0))
            startSound.run(.play())
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [self] in
                startSound.run(.stop())
            }
            self.addChild(startSound)      
            
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
