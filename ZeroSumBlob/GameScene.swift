import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIKit.UIColor.clearColor()

        let background = BackgroundNode()
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(background)
        FoodPopulator.seedInitialFood(background)

        let blob = BlobNode(color: RandomHelper.randomColor(), playerName: "mr. blob")
        blob.name = "me"
        blob.position = CGPoint(x: 0, y: 0)
        background.addChild(blob)

        let camera: CameraNode = CameraNode()
        self.addChild(camera)
        self.camera = camera

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }

    override func didSimulatePhysics() {
        if let blob: BlobNode = self.childNodeWithName("//me") as? BlobNode {
            self.camera?.position = CGPoint(x: self.size.width / 2 + blob.position.x / self.camera!.xScale,
                    y: self.size.height / 2 + blob.position.y / self.camera!.yScale)
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
            var foodValue = 1
            if let foodNode: FoodNode = foodPhysicsBody.node as? FoodNode {
                foodValue = foodNode.value
            }
            foodPhysicsBody.node?.removeFromParent()

            let blobPhysicsBody = contacts.filter {
                $0.categoryBitMask == PhysicsCategory.Blob
            }[0]
            if let blob: BlobNode = blobPhysicsBody.node as? BlobNode,
            let background = self.childNodeWithName("background") as? BackgroundNode,
            let camera = self.childNodeWithName("camera") as? CameraNode {
                blob.addVolume(foodValue)
                FoodPopulator.addRandomFood(background)
                camera.zoomForBlobSize(blob.blobRadius, maxBlobRadius: BlobNode.maxBlobRadius)
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