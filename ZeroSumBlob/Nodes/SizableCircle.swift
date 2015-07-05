import Foundation
import SpriteKit

class SizableCircle: SKShapeNode {
    var radius: Float {
        didSet {
            self.path = SizableCircle.path(self.radius)
        }
    }

    init(radius: Float) {
        self.radius = radius
        super.init()
        self.path = SizableCircle.path(self.radius)
    }

    class func path(radius: Float) -> CGMutablePathRef {
        var path: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddArc(path, nil, CGFloat(0.0), CGFloat(0.0), CGFloat(radius),
                CGFloat(0.0),
                CGFloat(2.0 * M_PI), true)
        return path
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
