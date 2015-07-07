import Foundation
import SpriteKit

class BackgroundNode: SKNode {
    override init() {
        super.init()
        self.name = "background"
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "background.png")
        self.addChild(backgroundImage)

        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.calculateAccumulatedFrame())
        self.physicsBody?.dynamic = false
        self.physicsBody?.restitution = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func zoomForBlobSize(blobRadius: Float, maxBlobRadius: Float) {
        let radiusScales = [80: 0.75, 100: 0.5, 150: 0.25, 0: 1]
        for boundarySize in (radiusScales.keys.array.sort {
            $0 > $1
        }) {
            if (blobRadius > Float(boundarySize)) {
                self.runAction(SKAction.scaleTo(CGFloat(radiusScales[boundarySize]!), duration: 1))
                break
            }
        }
    }

    func followBlob() {
        if let blob: SKNode = self.childNodeWithName("//me") {
            let parent: SKScene = self.parent as! SKScene
            let converted: CGPoint = parent.convertPoint(blob.position, toNode: parent)
            let newBackgroundPoint = CGPoint(x: -converted.x * self.xScale + parent.size.width / 2,
                    y: -converted.y * self.yScale + parent.size.height / 2)
            self.position = newBackgroundPoint
        }
    }
}
