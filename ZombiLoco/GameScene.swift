import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdatedTime: TimeInterval = 0 // Tener control de cuando ha sido la ultiima vez que hemos actualizado la pantalla en el metodo update
    var dt: TimeInterval = 0 // Delta Time desde la ultima actualizacion
    let zombiePixelPerSecond: CGFloat = 300.0
    var velocity = CGPoint.zero
    let playableArea: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight) / 2.0
        playableArea = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("El metodo init coder no ha sido implementado")
    }
    
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
        let touch = touches.first as! UITouch
        let location = touch.location(in: self)
        sceneTouched(touchLocation: location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdatedTime > 0 {
            dt = currentTime - lastUpdatedTime
        } else {
            dt = 0
        }
        
        lastUpdatedTime = currentTime
        //zombie.position = CGPoint(x: zombie.position.x+5, y: zombie.position.y)
        moveSprite(sprite: zombie, velocity: velocity)
        checkBounds()
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
    
    func sceneTouched(touchLocation: CGPoint) {
        moveZombieToLocation(location: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as! UITouch
        let location = touch.location(in: self)
        sceneTouched(touchLocation: location)
    }
    
    func checkBounds() {
        let bottomLeft = CGPoint(x: 0, y: playableArea.minY)
        let upperRight = CGPoint(x: size.width, y: playableArea.maxY)
        
        // Limite izquierdo
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        // Limite inferior
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        // Limite derecho
        if zombie.position.x >= upperRight.x {
            zombie.position.x = upperRight.x
            velocity.x = -velocity.x
        }
        
        // Limite superior
        if zombie.position.y >= upperRight.y {
            zombie.position.y = upperRight.y
            velocity.y = -velocity.y
        }
    }
    
}
