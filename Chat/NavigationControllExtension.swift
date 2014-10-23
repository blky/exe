import Foundation
let Tcolor = UIColor(red: 192 / 255, green: 209 / 255, blue: 138 / 255, alpha: 1.0)
extension UINavigationController {
    func CheckedInColor() {
        navigationBar.barTintColor =  Tcolor
        navigationBar.tintColor = UIColor.whiteColor()
    }
}