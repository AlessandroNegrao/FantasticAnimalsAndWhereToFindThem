import PlaygroundSupport
import SpriteKit
import Dispatch
import Foundation

public func scene2(){
    
    class GameScene: SKScene{
        var cameraIsClicked = false
        var nextPage: SKButtonNode?
        let backgroundMusic = SKAudioNode(fileNamed: "forest-sound.mpeg")
        let cameraShutter = SKAudioNode(fileNamed: "cameraShutter.mp3")
        let positiveSound = SKAudioNode(fileNamed: "positiveSound.wav")
        
        private var texto: SKLabelNode!
        
        
        override func sceneDidLoad() {
            super.sceneDidLoad()
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFill
            
            let river = SKSpriteNode(imageNamed: "scene 1.png")
            river.zPosition = 0
            
            self.addChild(river)
            self.addChild(cameraScreen)
            self.addChild(piramboiaCard)
            backgroundSound()
            //playFlappingWings()
            //lili cantou
            appearButton()        
        }
        
        
        
        private lazy var piramboia: SKSpriteNode = {
            let piramboia = SKSpriteNode(imageNamed: "piramboia 1.png")
            piramboia.position = CGPoint(x: -400, y: -500)
            piramboia.zPosition = 8
            piramboia.name = "piramboia"
            return piramboia
        }()
        
        
        
        private lazy var camera1: SKSpriteNode = {
            let camera1 = SKSpriteNode(imageNamed: "camera.png")
            camera1.position = CGPoint(x: -470, y: -750)
            camera1.zPosition = 1
            camera1.setScale(0.3)
            return camera1
        }()
        
        var cameraScreen: SKSpriteNode = {
            let cameraScreen = SKSpriteNode(imageNamed: "screen camera 2.png")
            cameraScreen.position = CGPoint(x: -100, y: 0)
            cameraScreen.zPosition = 2
            cameraScreen.setScale(0)
            return cameraScreen
        }()
        
        private lazy var piramboiaCard: SKSpriteNode = {
            let piramboiaCard = SKSpriteNode(imageNamed: "piramboia-card.png")
            piramboiaCard.position = CGPoint(x: 0, y: 0)
            piramboiaCard.zPosition = 5
            piramboiaCard.setScale(0)
            return piramboiaCard
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
                if piramboia.contains(CGPoint(x: 0, y: 150))  
                    && node.name == "piramboia"{
                    
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
                        piramboia.setScale(0)
                        cameraScreen.setScale(0)
                        piramboiaCard.setScale(1)
                        //flappingWings.run(.stop())
                    }
                }
            }
        }
        
        func animationPiramboia(){
            var frgoTextures = [SKTexture]()
            for i in 1...12{
                frgoTextures.append(SKTexture(imageNamed: "piramboia \(i)"))
            }
            let animationAction = SKAction.animate(with: frgoTextures, timePerFrame: 0.45)
            let repeatAction = SKAction.repeatForever(animationAction)
            
            piramboia.run(repeatAction)
            
            piramboia.run(.repeatForever(.sequence([
                //Up in the river
                .move(to: .init(x: -350, y: -400), duration: 0.4),
                .move(to: .init(x: -280, y: -300), duration: 0.4),
                .move(to: .init(x: -200, y: -150), duration: 0.4),
                .move(to: .init(x: -100, y: 0), duration: 0.4),
                .move(to: .init(x: 0, y: 150), duration: 0.4),
                .move(to: .init(x: 100, y: 300), duration: 0.4),
                .move(to: .init(x: 200, y: 400), duration: 0.4),
                //Down in the river
                .move(to: .init(x: 100, y: 300), duration: 0.4),
                .move(to: .init(x: 0, y: 150), duration: 0.4),
                .move(to: .init(x: -100, y: 0), duration: 0.4),
                .move(to: .init(x: -200, y: -150), duration: 0.4),
                .move(to: .init(x: -280, y: -300), duration: 0.4),
                .move(to: .init(x: -350, y: -400), duration: 0.4),
                .move(to: .init(x: -400, y: -500), duration: 0.4)
                
            ])))
            
        }
        
        public func playFlappingWings() {   
            let flappingWings = SKAudioNode(fileNamed: "Flapping Wings.mp3")
            flappingWings.run(SKAction.changeVolume(to: Float(0.05), duration: 0))
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
            self.addChild(piramboia)
            animationPiramboia()
        }
        
    }
    
    var view1 = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 1325, height: 1999)))
    var scene1 = GameScene(size: view1.frame.size)
    view1.presentScene(scene1)
    PlaygroundPage.current.setLiveView(view1)
    
}

