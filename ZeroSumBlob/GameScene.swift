import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIKit.UIColor.clearColor()

        let background = BackgroundNode()
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
        FoodPopulator.seedInitialFood(background)

        let blob = BlobNode(color: UIKit.UIColor.greenColor(), playerName: "mr. blob")
        blob.name = "me"
        background.addChild(blob)

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }

    override func didSimulatePhysics() {
        if let blob: SKNode = self.childNodeWithName("//me"),
        let background: SKNode = self.childNodeWithName("background") {
            let converted: CGPoint = self.convertPoint(blob.position, toNode: self)
            let newBackgroundPoint = CGPoint(x: -converted.x + self.size.width / 2,
                    y: -converted.y + self.size.height / 2)
            background.position = newBackgroundPoint
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.moveToward(touches.first!)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.moveToward(touches.first!)
    }

    func didBeginContact(contact: SKPhysicsContact) {
        let contacts = [contact.bodyA, contact.bodyB]
        let contactBitMasks = contacts.map {
            $0.categoryBitMask
        }
        if ([PhysicsCategory.Blob, PhysicsCategory.Food].reduce(true) {
            $0 && contactBitMasks.contains($1)
        }) {
            let foodPhysicsBody = contacts.filter {
                $0.categoryBitMask == PhysicsCategory.Food
            }[0]
            foodPhysicsBody.node?.removeFromParent()

            let blobPhysicsBody = contacts.filter {
                $0.categoryBitMask == PhysicsCategory.Blob
            }[0]
            if let blob: BlobNode = blobPhysicsBody.node as? BlobNode,
            let background = self.childNodeWithName("background") as? BackgroundNode {
                FoodPopulator.addRandomFood(background)
                blob.addVolume(1)
            }
        }
    }

    func moveToward(touch: UITouch) {
        if let blob: BlobNode = self.childNodeWithName("//me") as? BlobNode {
            let touchPoint: CGPoint = touch.locationInNode(self.childNodeWithName("background")!)
            blob.moveTowardPoint(touchPoint)
        }
    }
}