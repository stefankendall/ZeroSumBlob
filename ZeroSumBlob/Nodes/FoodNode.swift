import Foundation
import SpriteKit

class FoodNode: SKNode {
    var value: Int = 1

    override init() {
        super.init()

        let foodLength = 15
        let foodSize = CGSize(width: foodLength, height: foodLength)
        let body: SKShapeNode = SKShapeNode(rectOfSize: foodSize)
        body.fillColor = RandomHelper.randomColor()
        body.strokeColor = body.fillColor.lighterColorWithBrightnessFactor(-0.2)
        self.addChild(body)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: foodSize)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Food
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}