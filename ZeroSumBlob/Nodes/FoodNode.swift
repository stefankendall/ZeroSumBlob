import Foundation
import SpriteKit

class FoodNode: SKNode {
    override init() {
        super.init()

        let foodLength = 15
        let foodSize = CGSize(width: foodLength, height: foodLength)
        let body: SKShapeNode = SKShapeNode(rectOfSize: foodSize)
        body.fillColor = UIColor.blueColor()
        self.addChild(body)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: foodSize)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Food
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}