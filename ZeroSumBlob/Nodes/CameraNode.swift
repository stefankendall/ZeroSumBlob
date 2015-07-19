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
}