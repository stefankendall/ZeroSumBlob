import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIKit.UIColor.clearColor()

        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.name = "background"
        self.addChild(background)

        let blob = BlobNode(color: UIKit.UIColor.greenColor(), playerName: "mr. blob")
        blob.name = "me"
        background.addChild(blob)

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }

    override func update(currentTime: CFTimeInterval) {
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.moveToward(touches.first!)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.moveToward(touches.first!)
    }

    func moveToward(touch: UITouch) {
        let blob: BlobNode = self.childNodeWithName("//me") as! BlobNode
        let touchPoint: CGPoint = touch.locationInNode(self.childNodeWithName("background")!)
        blob.moveTowardPoint(touchPoint)
    }
}