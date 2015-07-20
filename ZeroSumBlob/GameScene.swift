import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var contactQueue: [SKPhysicsContact] = []

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
            let position: CGPoint = self.convertPoint(blob.position, fromNode: blob.parent!)
            self.camera?.position = position
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches.count == 1) {
            self.moveToward(touches.first!)
        } else {
            self.enumerateChildNodesWithName("//me") {
                (blob: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                (blob as! BlobNode).splitting = true
            }
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches.count == 1) {
            self.moveToward(touches.first!)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.enumerateChildNodesWithName("//me") {
            (blob: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            (blob as! BlobNode).splitting = false
        }
    }

    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        for contact: SKPhysicsContact in self.contactQueue {
            self.handleContact(contact)
        }
    }

    func handleContact(contact: SKPhysicsContact) {
        let contacts = [contact.bodyA, contact.bodyB]
        let contactBitMasks = contacts.map {
            $0.categoryBitMask
        }
        if ([PhysicsCategory.MyBlob, PhysicsCategory.Food].reduce(true) {
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
                $0.categoryBitMask == PhysicsCategory.MyBlob
            }[0]
            if let blob: BlobNode = blobPhysicsBody.node as? BlobNode,
            let background = self.childNodeWithName("background") as? BackgroundNode,
            let camera = self.childNodeWithName("camera") as? CameraNode {
                blob.addVolume(foodValue)
                FoodPopulator.addRandomFood(background)
                camera.zoomForBlobSize(blob.blobRadius)
            }
        }
    }

    func didBeginContact(contact: SKPhysicsContact) {
        self.contactQueue.append(contact)
    }

    func moveToward(touch: UITouch) {
        let background: SKNode = self.childNodeWithName("background")!
        self.enumerateChildNodesWithName("//me") {
            (blob: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            let touchPoint: CGPoint = touch.locationInNode(background)
            (blob as! BlobNode).moveTowardPoint(touchPoint)
        }
    }
}