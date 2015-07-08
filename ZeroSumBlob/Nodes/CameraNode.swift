import Foundation
import SpriteKit

class CameraNode : SKCameraNode {
    override init() {
        super.init()
        self.name = "camera"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    func zoomForBlobSize(blobRadius: Float, maxBlobRadius: Float) {
        let radiusScales = [80: 1.5, 120: 2, 160: 2.5, 0: 1]
        for boundarySize in (radiusScales.keys.array.sort {
            $0 > $1
        }) {
            if (blobRadius > Float(boundarySize)) {
                self.runAction(SKAction.scaleTo(CGFloat(radiusScales[boundarySize]!), duration: 1))
                break
            }
        }
    }
}