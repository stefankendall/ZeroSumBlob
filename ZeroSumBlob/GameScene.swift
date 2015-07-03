import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIKit.UIColor.clearColor()

        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
    }

    override func update(currentTime: CFTimeInterval) {
    }
}