import Foundation

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let All: UInt32 = UInt32.max
    static let Blob: UInt32 = 0b1
    static let Food: UInt32 = 0b10
}