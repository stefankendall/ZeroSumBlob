import Foundation
import SpriteKit
import UIKit

class BlobNode: SKNode {
    override init() {
        super.init()

        let body: SKShapeNode = SKShapeNode(circleOfRadius: 20);
        body.fillColor = UIColor.greenColor()
        self.addChild(body)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
