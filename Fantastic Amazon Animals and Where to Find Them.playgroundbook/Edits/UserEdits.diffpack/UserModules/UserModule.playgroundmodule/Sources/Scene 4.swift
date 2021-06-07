import PlaygroundSupport
import SpriteKit
import Dispatch
import Foundation

public func scene4(){
    
    class GameScene: SKScene{
        var cameraIsClicked = false
        var nextPage: SKButtonNode?
        let cameraShutter = SKAudioNode(fileNamed: "cameraShutter.mp3")
        let positiveSound = SKAudioNode(fileNamed: "positiveSound.wav")
        let flappingWings = SKAudioNode(fileNamed: "Flapping Wings.mp3")
        let backgroundMusic = SKAudioNode(fileNamed: "forest-sound.mpeg")
        
        
        override func sceneDidLoad() {
            super.sceneDidLoad()
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFill
            
            let forest = SKSpriteNode(imageNamed: "scene 3.png")
            forest.zPosition = 0
            
            self.addChild(forest)
            self.addChild(olwCard)
            self.addChild(cameraScreen)
            backgroundSound()
            playFlappingWings()
            appearButton()   
            
        }
        
        private lazy var owl: SKSpriteNode = {
            let owl = SKSpriteNode(imageNamed: "owl 1.png")
            owl.position = CGPoint(x: -350, y: 220)
            owl.zPosition = 2
            owl.name = "owl"
            return owl
        }()
        
        
        
        private lazy var camera1: SKSpriteNode = {
            let camera1 = SKSpriteNode(imageNamed: "camera.png")
            camera1.position = CGPoint(x: -470, y: -650)
            camera1.zPosition = 1
            camera1.setScale(0.3)
            return camera1
        }()
        
        private lazy var olwCard: SKSpriteNode = {
            let olwCard = SKSpriteNode(imageNamed: "suidara-card.png")
            olwCard.position = CGPoint(x: 0, y: 0)
            olwCard.zPosition = 5
            olwCard.setScale(0)
            return olwCard
        }()
        
        var cameraScreen: SKSpriteNode = {
            let cameraScreen = SKSpriteNode(imageNamed: "screen camera 2.png")
            cameraScreen.position = CGPoint(x: 0, y: -100)
            cameraScreen.zPosition = 1
            cameraScreen.setScale(0)
            return cameraScreen
        }()
        
        func createScreenCamera(){ 
            
            cameraScreen.setScale(1)
            camera1.setScale(0)
            cameraIsClicked = true
            
        }
        
        func appearButton() {
            DispatchQueue.main.asyncAfter(deadline: .now()){ [self] in
                var cameraButton = SKButtonNode(image: camera1, label: SKLabelNode()){
                    createScreenCamera()
                }
                self.addChild(cameraButton)
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first{
                    let location = touch.location(in: self)
                    let node: SKNode = self.atPoint(location)
                    if owl.contains(CGPoint(x: 0, y: -100)) && node.name == "owl"{
                        if cameraIsClicked {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()){ [self] in
                                nextPage = SKButtonNode(image: finishImage, label: SKLabelNode()){
                                    positiveSoundFunc()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
                                        PlaygroundPage.current.navigateTo(page: .next)
                                    }
                                }
                                self.addChild(self.nextPage!)
                            }
                            cameraClick()
                            cameraScreen.setScale(0)
                            olwCard.setScale(1)
                            flappingWings.run(.stop())
                        }
                    }
            }
            }
        
        
        
        func animationOwl(){
            var owlTextures = [SKTexture]()
            for i in 1...14 {
                owlTextures.append(SKTexture(imageNamed: "owl \(i)"))
            }
            let animationAction = SKAction.animate(with: owlTextures, timePerFrame: 0.4)
            let repeatAction = SKAction.repeatForever(animationAction)
            
            owl.run(repeatAction)
            
            owl.run(.repeatForever(.sequence([
                .move(to: .init(x: 0, y: -100), duration: 1.4),
                .move(to: .init(x: 350, y: 220), duration: 1.4),
                .move(to: .init(x: 0, y: -100), duration: 1.4),
                .move(to: .init(x: -350, y: 220), duration: 1.4)
            ])))
            
        }
        
        
        public func playFlappingWings() {   
            flappingWings.run(SKAction.changeVolume(to: Float(0.08), duration: 0))
            flappingWings.run(.play())
            self.addChild(flappingWings)      
            
        }
        
        public func backgroundSound() {   
            backgroundMusic.run(SKAction.changeVolume(to: Float(0.08), duration: 0))
            backgroundMusic.run(.play())
            self.addChild(backgroundMusic)      
            
        }
        
        public func cameraClick() {   
            cameraShutter.run(SKAction.changeVolume(to: Float(0.4), duration: 0))
            cameraShutter.run(.play())
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [self] in
                cameraShutter.run(.stop())
            }
            self.addChild(cameraShutter)      
            
        }
        
        public func positiveSoundFunc() {   
            positiveSound.run(SKAction.changeVolume(to: Float(0.4), duration: 0))
            positiveSound.run(.play())
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [self] in
                positiveSound.run(.stop())
            }
            self.addChild(positiveSound)      
            
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
