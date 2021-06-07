import PlaygroundSupport
import SpriteKit
import Dispatch
import Foundation

public func scene5(){
    
    class GameScene: SKScene{
        
        let backgroundMusic = SKAudioNode(fileNamed: "adventure-sound.mpeg")
        
        override func sceneDidLoad() {
            super.sceneDidLoad()
            self.anchorPoint = .init(x: 0.5, y: 0.5)
            self.scaleMode = .aspectFill
            
            let river = SKSpriteNode(imageNamed: "table.png")
            river.zPosition = 0
            
            self.addChild(river)
            backgroundSound()
            
        }
        
        
        
        public func backgroundSound() {   
            backgroundMusic.run(SKAction.changeVolume(to: Float(0.08), duration: 0))
            backgroundMusic.run(.play())
            self.addChild(backgroundMusic)    
            
            
        }
        
    }
    
    var view1 = SKView(frame: CGRect(origin: .zero, size: CGSize(width: 1325, height: 1999)))
    var scene1 = GameScene(size: view1.frame.size)
    view1.presentScene(scene1)
    PlaygroundPage.current.setLiveView(view1)
    
}


