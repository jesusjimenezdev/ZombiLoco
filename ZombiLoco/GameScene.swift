import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdatedTime: TimeInterval = 0 // Tener control de cuando ha sido la ultiima vez que hemos actualizado la pantalla en el metodo update
    var dt: TimeInterval = 0 // Delta Time desde la ultima actualizacion
    let zombiePixelPerSecond: CGFloat = 300.0
    var velocity = CGPoint.zero
    
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
        if lastUpdatedTime > 0 {
            dt = currentTime - lastUpdatedTime
        } else {
            dt = 0
        }
        
        lastUpdatedTime = currentTime
        //zombie.position = CGPoint(x: zombie.position.x+5, y: zombie.position.y)
        moveSprite(sprite: zombie, velocity: CGPoint(x: zombiePixelPerSecond, y: 0))
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        // Espacio = Velocidad * tiempo
        // Cantidad que tenemos que movernos
        let amount = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        sprite.position = CGPoint(x: sprite.position.x + amount.x, y: sprite.position.y + amount.y)
    }
    
    func moveZombieToLocation(location: CGPoint) {
        // Cantidad e movimiento que hay que incrementar al zombie para que llegue donde hemos tocado
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        // Teorema de pitagoras
        let offsetLength = sqrt(Double((offset.x * offset.x) + (offset.y * offset.y)))
        // Calculo de un vector unitario de movimiento
        let direction = CGPoint(x: offset.x/CGFloat(offsetLength), y: offset.y/CGFloat(offsetLength))
        // Calculo de la velocidad
        velocity = CGPoint(x: direction.x * zombiePixelPerSecond, y: direction.y * zombiePixelPerSecond)
    }
    
}
