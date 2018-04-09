import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    
    override func didMove(to view: SKView) {
        //backgroundColor = SKColor.white
        let background = SKSpriteNode(imageNamed: "background1")
        //background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        //background.zRotation = CGFloat(Double.pi)/8
        addChild(background)
        
        let sizeBackgroung = background.size
        print(sizeBackgroung)
        
        
        // Nodo zombie
        zombie.position = CGPoint(x: 300, y: 300)
        zombie.xScale = 1
        zombie.xScale = 1
        addChild(zombie)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
