import UIKit

extension UIColor {
    func lighterColorWithBrightnessFactor(brightnessFactor: CGFloat) -> UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + brightnessFactor, 1.0),
                    green: min(g + brightnessFactor, 1.0),
                    blue: min(b + brightnessFactor, 1.0),
                    alpha: a)
        }
        return UIColor()
    }
}