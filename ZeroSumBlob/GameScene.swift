import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIKit.UIColor.clearColor()

        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)

        let blob = BlobNode(name:"me", color: UIKit.UIColor.greenColor())
        background.addChild(blob)
    }

    override func update(currentTime: CFTimeInterval) {
    }
}