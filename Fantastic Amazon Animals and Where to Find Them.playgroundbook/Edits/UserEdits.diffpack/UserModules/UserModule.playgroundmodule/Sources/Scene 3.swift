import PlaygroundSupport
import SpriteKit
import Dispatch
import Foundation

public func scene3(){
    
    class GameScene: SKScene{
        var cameraIsClicked = false
        var nextPage: SKButtonNode?
        let cameraShutter = SKAudioNode(fileNamed: "cameraShutter.mp3")
        let positiveSound = SKAudioNode(fileNamed: "positiveSound.wav")
        let backgroundMusic = SKAudioNode(fileNamed: "forest-sound.mpeg")
        let jumpSound = SKAudioNode(fileNamed: "jumpSound.mp3")
        
        
        
        override func sceneDidLoad() {
            super.sceneDidLoad()
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFill
            
            let river = SKSpriteNode(imageNamed: "scene 2.png")
            river.zPosition = 0
            
            self.addChild(river)
            self.addChild(cameraScreen)
            self.addChild(frogCard)
            backgroundSound()
            playJumpSound()
            //pra aparecer a capa
            appearButton()        
        }
        
        private lazy var frog: SKSpriteNode = {
            let frog = SKSpriteNode(imageNamed: "frog 1.png")
            frog.position = CGPoint(x: -250, y: -750)
            frog.zPosition = 8
            frog.name = "frog"
            return frog
        }()
        
        
        
        private lazy var camera1: SKSpriteNode = {
            let camera1 = SKSpriteNode(imageNamed: "camera.png")
            camera1.position = CGPoint(x: -470, y: -600)
            camera1.zPosition = 1
            camera1.setScale(0.3)
            return camera1
        }()
        
        var cameraScreen: SKSpriteNode = {
            let cameraScreen = SKSpriteNode(imageNamed: "screen camera 2.png")
            cameraScreen.position = CGPoint(x: 0, y: -350)
            cameraScreen.zPosition = 2
            cameraScreen.setScale(0)
            return cameraScreen
        }()
        
        private lazy var frogCard: SKSpriteNode = {
            let frogCard = SKSpriteNode(imageNamed: "frog-card.png")
            frogCard.position = CGPoint(x: 0, y: 0)
            frogCard.zPosition = 5
            frogCard.setScale(0)
            return frogCard
        }()
        
        
        func createScreenCamera(){
            
            cameraScreen.setScale(0.65)
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
                if (frog.contains(CGPoint(x: 150, y: -250)) || frog.contains(CGPoint(x: -150, y: -250))) 
                    && node.name == "frog"{

                    if cameraIsClicked {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()){ [self] in
                            nextPage = SKButtonNode(image: buttonImage, label: SKLabelNode()){
                                positiveSoundFunc()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
                                    PlaygroundPage.current.navigateTo(page: .next)
                                    
                                }
                            }
                            self.addChild(self.nextPage!)
                        }
                        cameraClick()
                        frog.setScale(0)
                        cameraScreen.setScale(0)
                        frogCard.setScale(1)
                        jumpSound.run(.stop())
                    }
                }
            }
        }

        func animationFrog(){
            var frgoTextures = [SKTexture]()
            for i in 1...6 {
                frgoTextures.append(SKTexture(imageNamed: "frog \(i)"))
            }
            let animationAction = SKAction.animate(with: frgoTextures, timePerFrame: 0.4)
            let repeatAction = SKAction.repeatForever(animationAction)
            
            frog.run(repeatAction)
            
            frog.run(.repeatForever(.sequence([
                .move(to: .init(x: -150, y: -500), duration: 0.4),
                .move(to: .init(x: 150, y: -200), duration: 0.4),
                .move(to: .init(x: 350, y: -750), duration: 0.4),
                .move(to: .init(x: 0, y: -550), duration: 0.4),
                .move(to: .init(x: -150, y: -200), duration: 0.4),
                .move(to: .init(x: -250, y: -750), duration: 0.4)
                
            ])))
            
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
        
        public func playJumpSound() {   
            jumpSound.run(SKAction.changeVolume(to: Float(0.08), duration: 0))
            jumpSound.run(.play())
            self.addChild(jumpSound)      
            
        }
        
        override func didMove(to view: SKView) {
            self.addChild(frog)
            animationFrog()
        }
        
    }
    
    var view1 = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 1325, height: 1999)))
    var scene1 = GameScene(size: view1.frame.size)
    view1.presentScene(scene1)
    PlaygroundPage.current.setLiveView(view1)
    
}

