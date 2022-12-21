import UIKit

public extension UIWindow {
    static let safeAreaInsets: UIEdgeInsets = {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets ?? .zero
    }()

    static let safeAreaBottomInset: CGFloat = {
        UIWindow.safeAreaInsets.bottom
    }()

    static let safeAreaTopInset: CGFloat = {
        UIWindow.safeAreaInsets.top
    }()
}
