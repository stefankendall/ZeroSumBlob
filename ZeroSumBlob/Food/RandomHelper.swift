import Foundation

class RandomHelper {
    static func between0and1() -> Float {
        return Float(arc4random()) / Float(UInt32.max)
    }
}