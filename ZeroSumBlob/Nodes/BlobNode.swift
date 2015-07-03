import Foundation
import SpriteKit
import UIKit

class BlobNode: SKNode {
    init(name: String, color blobColor: UIColor) {
        super.init()

        self.name = name
        let body: SKShapeNode = SKShapeNode(circleOfRadius: 15);
        body.fillColor = blobColor
        body.lineWidth = 3;
        body.strokeColor = blobColor.lighterColorWithBrightnessFactor(-0.2)
        self.addChild(body)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
