import Foundation
import UIKit

class FoodPopulator {
    static let padding: Float = 10

    class func seedInitialFood(background: BackgroundNode) {
        let frame: CGRect = background.calculateAccumulatedFrame()
        let paddingWidth = CGFloat(Float(frame.size.width) - padding * 2)
        let paddingHeight = CGFloat(Float(frame.size.height) - padding * 2)
        for _ in 1 ... 200 {
            let food: FoodNode = FoodNode()
            background.addChild(food)
            let x = -paddingWidth / 2 + paddingWidth * CGFloat(RandomHelper.between0and1())
            let y = -paddingHeight / 2 + paddingHeight * CGFloat(RandomHelper.between0and1())
            food.position = CGPoint(x: x, y: y)
        }
    }

    class func addRandomFood(background: BackgroundNode) {
        let frame: CGRect = background.calculateAccumulatedFrame()
        let paddingWidth = CGFloat(Float(frame.size.width) - padding * 2)
        let paddingHeight = CGFloat(Float(frame.size.height) - padding * 2)

        let food: FoodNode = FoodNode()
        let x = randomNumberAround(paddingWidth)
        let y = randomNumberAround(paddingHeight)
        food.position = CGPoint(x: x, y: y)

        let intersectingNodes = background.children.filter { food.intersectsNode($0) }
        if intersectingNodes.count == 0 {
            background.addChild(food)
        }
    }

    class func randomNumberAround(number: CGFloat) -> CGFloat {
        return -number / 2 + number * CGFloat(Float(arc4random()) / Float(UInt32.max))
    }
}
