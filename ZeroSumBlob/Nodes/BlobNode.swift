import Foundation
import SpriteKit
import UIKit

class BlobNode: SKNode {

    static let minimumBlobRadius: Float = 15
    static let maxBlobRadius: Float = 25
    static let minimumFontSize: Float = 24
    var blobRadius: Float = minimumBlobRadius

    static let maximumMoveSpeed: CGFloat = 400
    static let minimumMoveSpeed: CGFloat = 100
    var moveSpeed: CGFloat = maximumMoveSpeed
    var movementAngle: CGFloat = 0
    var volume: Int = 0

    init(color blobColor: SKColor, playerName: String) {
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

        let playerNameLabel = DropShadowLabelNode()
        playerNameLabel.name = "name"
        playerNameLabel.text = playerName
        playerNameLabel.fontName = "AvenirNext-Bold"
        playerNameLabel.fontSize = CGFloat(max(BlobNode.minimumFontSize, self.blobRadius / 2))
        playerNameLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        playerNameLabel.addShadow()
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
        self.movementAngle = atan2(dy, dx)

        if (distance < CGFloat(self.blobRadius)) {
            let ratioFromEdge = Float(distance) / self.blobRadius
            if( ratioFromEdge < 0.2 ){
                self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
            else {
                let dx = ratioFromEdge * Float(cos(self.movementAngle)) * Float(self.moveSpeed)
                let dy = ratioFromEdge * Float(sin(self.movementAngle)) * Float(self.moveSpeed)
                self.physicsBody?.velocity = CGVector(dx: CGFloat(dx), dy: CGFloat(dy))
            }
        } else {
            self.setVelocityAlongMovementAngle()
        }
    }

    func setVelocityAlongMovementAngle() {
        self.physicsBody?.velocity = CGVector(dx: self.moveSpeed * cos(self.movementAngle), dy: self.moveSpeed * sin(self.movementAngle))
    }

    func addVolume(volume: Int) {
        self.volume += volume
        let radiusIncrease = Float(self.volume)
        let newRadius = round(Float(BlobNode.minimumBlobRadius) + radiusIncrease)
        if (newRadius != self.blobRadius) {
            self.blobRadius = newRadius
            self.updatePhysicsBody()
            let body: SizableCircle = self.childNodeWithName("body") as! SizableCircle
            body.radius = newRadius

            let playerNameLabel: SKLabelNode = self.childNodeWithName("name") as! SKLabelNode
            playerNameLabel.fontSize = CGFloat(max(BlobNode.minimumFontSize, self.blobRadius / 2))

            self.moveSpeed = max(BlobNode.minimumMoveSpeed, BlobNode.maximumMoveSpeed - CGFloat(self.volume))
            self.setVelocityAlongMovementAngle()
        }
    }
}
