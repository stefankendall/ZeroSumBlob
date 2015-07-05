import Foundation
import UIKit

class FoodPopulator {
    static let padding : Float = 10

    class func seedInitialFood(background: BackgroundNode) {
        let frame: CGRect = background.calculateAccumulatedFrame()
        let paddingWidth = CGFloat(Float(frame.size.width) - padding * 2)
        let paddingHeight = CGFloat(Float(frame.size.height) - padding * 2)
        for _ in 1 ... 100 {
            let food: FoodNode = FoodNode()
            background.addChild(food)
            let x = -paddingWidth / 2 + paddingWidth * CGFloat(Float(arc4random()) / Float(UInt32.max))
            let y = -paddingHeight / 2 + paddingHeight * CGFloat(Float(arc4random()) / Float(UInt32.max))
            food.position = CGPoint(x: x, y: y)
        }
    }

    class func addRandomFood(background: BackgroundNode){
        let frame: CGRect = background.calculateAccumulatedFrame()
        let paddingWidth = CGFloat(Float(frame.size.width) - padding * 2)
        let paddingHeight = CGFloat(Float(frame.size.height) - padding * 2)

        let food: FoodNode = FoodNode()
        background.addChild(food)
        let x = -paddingWidth / 2 + paddingWidth * CGFloat(Float(arc4random()) / Float(UInt32.max))
        let y = -paddingHeight / 2 + paddingHeight * CGFloat(Float(arc4random()) / Float(UInt32.max))
        food.position = CGPoint(x: x, y: y)
    }
}
