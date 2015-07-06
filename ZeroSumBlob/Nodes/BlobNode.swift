import Foundation
import SpriteKit
import UIKit

class BlobNode: SKNode {

    static let minimumBlobRadius: Float = 15
    static let maxBlobRadius: Float = 150
    var blobRadius: Float = minimumBlobRadius

    static let maximumMoveSpeed: CGFloat = 200
    var moveSpeed: CGFloat = maximumMoveSpeed
    var volume: Int = 0

    init(color blobColor: UIColor, playerName: String) {
        super.init()
        self.name = "blob"
        self.zPosition = 1
        self.updatePhysicsBody()
        let body: SizableCircle = SizableCircle(radius: self.blobRadius)
        body.name = "body"
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

    func updatePhysicsBody() {
        let velocity = self.physicsBody?.velocity
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.blobRadius))
        if let velocity = velocity {
            self.physicsBody?.velocity = velocity
        }
        self.physicsBody?.categoryBitMask = PhysicsCategory.Blob
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.Food & ~PhysicsCategory.Blob
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Food
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func moveTowardPoint(point: CGPoint) {
        let dx: CGFloat = point.x - self.position.x
        let dy: CGFloat = point.y - self.position.y
        let distance = hypot(dx, dy)
        let angle = atan2(dy, dx)

        if (distance < CGFloat(self.blobRadius)) {
            self.physicsBody?.velocity = CGVector(dx: distance * cos(angle), dy: distance * sin(angle))
        } else {
            self.physicsBody?.velocity = CGVector(dx: self.moveSpeed * cos(angle), dy: self.moveSpeed * sin(angle))
        }
    }

    func addVolume(volume: Int) {
        self.volume += volume
        let radiusIncrease = Float(self.volume)
        let newRadius = min(round(Float(BlobNode.minimumBlobRadius) + radiusIncrease), BlobNode.maxBlobRadius)
        if (newRadius != self.blobRadius) {
            self.blobRadius = newRadius
            self.updatePhysicsBody()
            let body: SizableCircle = self.childNodeWithName("body") as! SizableCircle
            body.radius = newRadius
        }
    }

    func isMaxSize() -> Bool {
        return self.blobRadius > BlobNode.maxBlobRadius
    }
}
