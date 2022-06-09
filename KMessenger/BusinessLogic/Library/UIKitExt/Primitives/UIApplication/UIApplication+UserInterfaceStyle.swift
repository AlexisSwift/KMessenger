import UIKit

public extension UIApplication {
    var userInterfaceStyle: UIUserInterfaceStyle? {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
}
