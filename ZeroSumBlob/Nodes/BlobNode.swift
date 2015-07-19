import Foundation
import SpriteKit
import UIKit

let DEBUG_START_BIG = true
let START_BIG_VOLUME: Int = 20

class BlobNode: SKNode {
    static let minimumBlobRadius: Float = 15
    static let minimumFontSize: Float = 24
    var blobRadius: Float = minimumBlobRadius
    var blobColor: UIColor = UIColor.clearColor()
    var playerName: String = ""

    static let maximumMoveSpeed: CGFloat = 300
    static let minimumMoveSpeed: CGFloat = 100

    static let blobEdgeWidth: Float = 3

    var moveSpeed: CGFloat = maximumMoveSpeed
    var movementAngle: CGFloat = 0
    var volume: Int = 0

    var splitting: Bool = false {
        didSet {
            if (splitting) {
                self.startSplitting()
            } else {
                self.stopSplitting()
            }
        }
    }

    func startSplitting() {
        self.removeSplittingOverlay()
        let splitOverlay: SizableCircle = SizableCircle(radius: self.blobRadius + Float(BlobNode.blobEdgeWidth))
        splitOverlay.fillColor = UIColor.blackColor()
        splitOverlay.alpha = 0.3
        splitOverlay.name = "overlay"
        splitOverlay.setScale(0.3)
        splitOverlay.zPosition = 50
        self.addChild(splitOverlay)
        splitOverlay.runAction(
        SKAction.sequence([
                SKAction.scaleTo(1, duration: 0.5),
                SKAction.runBlock({
                    if (self.splitting) {
                        self.split()
                    }
                })
        ])
        )
    }

    func split() {
        let splitNode: BlobNode = BlobNode(color: self.blobColor, playerName: self.playerName)
        splitNode.addVolume(self.volume / 2)
        splitNode.name = "me"
        self.addVolume(-self.volume / 2)
        splitNode.position = self.position
        self.parent?.addChild(splitNode)

        self.splitting = false
    }

    func stopSplitting() {
        self.removeSplittingOverlay()
    }

    func removeSplittingOverlay() {
        if let overlay = self.childNodeWithName("overlay") {
            overlay.removeFromParent()
        }
    }

    init(color blobColor: SKColor, playerName: String) {
        super.init()
        self.name = "blob"
        self.zPosition = 1
        self.blobColor = blobColor
        self.playerName = playerName
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
        self.addVolume(DEBUG_START_BIG ? START_BIG_VOLUME : 0)
    }

    func updatePhysicsBody() {
        let velocity = self.physicsBody?.velocity
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.blobRadius))
        if let velocity = velocity {
            self.physicsBody?.velocity = velocity
        }
        self.physicsBody?.categoryBitMask = PhysicsCategory.MyBlob
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
            if (ratioFromEdge < 0.2) {
                self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else {
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
        let newRadius = max(round(Float(BlobNode.minimumBlobRadius) + radiusIncrease), BlobNode.minimumBlobRadius)
        if (newRadius != self.blobRadius) {
            self.blobRadius = newRadius
            self.updatePhysicsBody()
            let body: SizableCircle = self.childNodeWithName("body") as! SizableCircle
            body.radius = newRadius

            if let splitOverlay = self.childNodeWithName("overlay") as? SizableCircle {
                splitOverlay.radius = newRadius + BlobNode.blobEdgeWidth
            }

            let playerNameLabel: SKLabelNode = self.childNodeWithName("name") as! SKLabelNode
            playerNameLabel.fontSize = CGFloat(max(BlobNode.minimumFontSize, self.blobRadius / 2))

            self.moveSpeed = max(BlobNode.minimumMoveSpeed, BlobNode.maximumMoveSpeed - 3 * CGFloat(self.volume))
            self.setVelocityAlongMovementAngle()
        }
    }
}
