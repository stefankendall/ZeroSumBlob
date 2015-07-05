import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: self.view.bounds.size)
        scene.scaleMode = .ResizeFill

        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
