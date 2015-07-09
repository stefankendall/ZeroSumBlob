import Foundation
import SpriteKit

class RandomHelper {
    static func between0and1() -> Float {
        return Float(arc4random()) / Float(UInt32.max)
    }

    static func randomColor() -> SKColor {
        return SKColor(hue: CGFloat(RandomHelper.between0and1()), saturation: 1, brightness: 1, alpha: 1)
    }
}