import Foundation
import SpriteKit

class FoodNode: SKNode {
    override init() {
        super.init()

        let foodSize = 15
        let body: SKShapeNode = SKShapeNode(rectOfSize: CGSize(width: foodSize, height: foodSize))
        body.fillColor = UIColor.blueColor()
        self.addChild(body)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}