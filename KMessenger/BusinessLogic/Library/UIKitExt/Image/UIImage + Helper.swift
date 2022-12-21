// Source: https://stackoverflow.com/questions/30858969/can-the-height-of-the-uisearchbar-textfield-be-modified

import UIKit

extension UIImage {
    
    /// Create custom `UIImage`.
    ///
    /// If you use:
    /// ```
    /// func setSearchFieldBackgroundImage(backgroundImage: UIImage?, forState state: UIControlState)
    /// ```
    /// The height of UISearchBar's UITextfield would be the same as the height of the Image. You can drop in an Image, use it to customize UISearchBar's UITextfield height and backgroundImage.
    ///
    /// - Returns: A rendered `UIImage` that is convenient to use for the `UISearchTextField` background.
    static func image(color: UIColor = .clear, size: CGSize = CGSize(width: 1, height: 40)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            color.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
