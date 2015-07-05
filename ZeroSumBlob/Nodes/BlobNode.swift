import Foundation
import SpriteKit
import UIKit

class BlobNode: SKNode {
    var blobRadius: CGFloat
    var moveSpeed: CGFloat

    init(color blobColor: UIColor, playerName: String) {
        self.blobRadius = 15
        self.moveSpeed = 200
        super.init()

        self.physicsBody = SKPhysicsBody(circleOfRadius: self.blobRadius)
        self.physicsBody?.linearDamping = 0

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
        let dx: CGFloat = point.x - self.position.x
        let dy: CGFloat = point.y - self.position.y
        let distance = hypot(dx, dy)
        let angle = atan2(dy, dx)

        if (distance < self.blobRadius) {
            self.physicsBody?.velocity = CGVector(dx: distance * cos(angle), dy: distance * sin(angle))
        } else {
            self.physicsBody?.velocity = CGVector(dx: self.moveSpeed * cos(angle), dy: self.moveSpeed * sin(angle))
        }
    }

    func stopMoving() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
}
