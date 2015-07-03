import Foundation
import SpriteKit
import UIKit

class BlobNode: SKNode {
    var blobRadius: CGFloat

    init(color blobColor: UIColor, playerName: String) {
        self.blobRadius = 15
        super.init()

        self.physicsBody = SKPhysicsBody(circleOfRadius: self.blobRadius)

        let body: SKShapeNode = SKShapeNode(circleOfRadius: self.blobRadius);
        body.fillColor = blobColor
        body.lineWidth = 3;
        body.strokeColor = blobColor.lighterColorWithBrightnessFactor(-0.2)
        self.addChild(body)

        let playerNameLabel = SKLabelNode(text: playerName)
        playerNameLabel.fontName = "AvenirNext-Bold"
        playerNameLabel.fontSize = 12
        playerNameLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        self.addChild(playerNameLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func moveTowardPoint(point: CGPoint) {
        self.physicsBody!.velocity = CGVector(dx: point.x - self.position.x, dy: point.y - self.position.y)
    }
}
