import Kingfisher
import SkeletonView

extension UIImageView {
    @discardableResult
    func setImage(
        withUrl urlString: String,
        placeholder: UIImage? = nil,
        completion: OptionalUIImageHandler? = nil
    ) -> Self {
        guard
            let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedString)
        else {
            return self
        }
        
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
        
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options:
            [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    completion?(value.image)
                case .failure:
                    completion?(nil)
                }
                self.hideSkeleton()
            }
        )
        return self
    }
}
