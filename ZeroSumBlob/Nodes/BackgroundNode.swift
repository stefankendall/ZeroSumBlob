import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    override init() {
        super.init()
        self.name = "background"
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "background.png")
        self.addChild(backgroundImage)

        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.calculateAccumulatedFrame())
        self.physicsBody?.dynamic = false
        self.physicsBody?.restitution = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

}
