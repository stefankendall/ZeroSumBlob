import Foundation
import SpriteKit

class DropShadowLabelNode: SKLabelNode {
    override var fontSize: CGFloat {
        didSet {
            if let shadow = self.childNodeWithName("shadow") as? SKLabelNode {
                shadow.fontSize = self.fontSize
            }
        }
    }

    func addShadow() {
        let dropShadow: SKLabelNode = SKLabelNode()
        dropShadow.name = "shadow"
        dropShadow.text = self.text
        dropShadow.fontName = self.fontName
        dropShadow.fontSize = self.fontSize
        dropShadow.zPosition = self.zPosition + 1
        let offset = 2
        dropShadow.position = CGPoint(x: -offset, y: +offset)
        dropShadow.verticalAlignmentMode = self.verticalAlignmentMode
        dropShadow.fontColor = SKColor.whiteColor()
        self.addChild(dropShadow)
    }

    override init() {
        super.init()
        self.zPosition = 2
        self.fontColor = SKColor.blackColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
}
