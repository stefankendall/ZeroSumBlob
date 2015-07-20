import Foundation
import SpriteKit

class CameraNode: SKCameraNode {
    override init() {
        super.init()
        self.name = "camera"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    func zoomForBlobSize(blobRadius: Float) {
        let radiusScales = [80: 1.5, 120: 2, 160: 2.25, 0: 1]
        for boundarySize in (radiusScales.keys.array.sort {
            $0 > $1
        }) {
            let boundaryScale: CGFloat = CGFloat(radiusScales[boundarySize]!)
            if (blobRadius > Float(boundarySize)) {
                if (fabs(self.xScale - boundaryScale) > 0.01) {
                    self.removeActionForKey("scale")
                    self.runAction(SKAction.scaleTo(boundaryScale, duration: 1), withKey: "scale")
                }
                break
            }
        }
    }

    func follow(blobs: [SKNode]) {
        var midPoint: CGPoint = CGPoint(x: 0, y: 0)
        for node: SKNode in blobs {
            let converted: CGPoint = self.parent!.convertPoint(node.position, fromNode: node.parent!)
            midPoint = CGPoint(x: midPoint.x + converted.x, y: midPoint.y + converted.y)
        }
        let midX = Float(midPoint.x) / Float(blobs.count)
        let midY = Float(midPoint.y) / Float(blobs.count)
        self.position = CGPoint(x: CGFloat(midX), y: CGFloat(midY))
    }
}