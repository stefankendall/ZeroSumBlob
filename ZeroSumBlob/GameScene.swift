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
        if let blob: SKNode = self.childNodeWithName("//me"),
        let background: SKNode = self.childNodeWithName("background")! {
            let converted: CGPoint = self.convertPoint(blob.position, toNode: self)
            background.position = CGPoint(x: -converted.x + self.size.width / 2,
                    y: -converted.y + self.size.height / 2)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.moveToward(touches.first!)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.moveToward(touches.first!)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let blob: BlobNode = self.childNodeWithName("//me") as? BlobNode {
            blob.stopMoving()
        }
    }

    func moveToward(touch: UITouch) {
        if let blob: BlobNode = self.childNodeWithName("//me") as? BlobNode {
            let touchPoint: CGPoint = touch.locationInNode(self.childNodeWithName("background")!)
            blob.moveTowardPoint(touchPoint)
        }
    }
}