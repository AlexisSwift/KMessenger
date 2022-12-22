import UIKit

final class SearchBar: UISearchBar {
    
    convenience init() {
        self.init(frame: .zero)
        configureAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Configure
private extension SearchBar {
    func configureAppearance() {
        tintColor = Palette.colorAccent
        showsBookmarkButton = true
        searchBarStyle = .minimal
        
        setImage(Image.xClear(), for: .clear, state: .normal)
        setImage(Image.filterList(), for: .bookmark, state: .normal)
        setValue(L10n.cancelSearchBarTitle(), forKey: "cancelButtonText")
        
        setSearchFieldBackgroundImage(UIImage.image(color: .systemGray6), for: .normal)
        setPositionAdjustment(Constants.adjustingTextOffset, for: .search)
        setPositionAdjustment(Constants.adjustingRightIconOffset, for: .bookmark)
        setPositionAdjustment(Constants.adjustingRightIconOffset, for: .clear)
        searchTextPositionAdjustment = Constants.adjustingTextOffset
        
        searchTextField.spellCheckingType = .no
        searchTextField.autocorrectionType = .no
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.rightViewMode = .unlessEditing
        searchTextField.textAlignment = .left
        searchTextField.font = .systemFont(ofSize: 15, weight: .regular)
        searchTextField.tintColor = .systemGray2
        searchTextField.attributedPlaceholder = Constants.placeholderAttributedString
        searchTextField.leftView = UIImageView.init(image: Image.magnifyingGlass())
        searchTextField.layer.cornerRadius = 16
        searchTextField.layer.masksToBounds = true
        
        let barButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearance.setTitleTextAttributes(Constants.cancelBarButtonAttributes, for: .normal)
    }
}

// MARK: - Constants
private extension SearchBar {
    private enum Constants {
        static let activeTextFont: UIFont = .systemFont(ofSize: 15, weight: .regular)
        static let adjustingTextOffset: UIOffset = .init(horizontal: 10, vertical: .zero)
        static let adjustingRightIconOffset: UIOffset = .init(horizontal: -10, vertical: .zero)
        static let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .medium),
            .foregroundColor: UIColor.systemGray,
        ]
        static let cancelBarButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15),
            .foregroundColor: Palette.colorAccent,
        ]
        static let placeholderAttributedString: NSAttributedString = .init(
            string: L10n.placeholderSearchBarTitle(),
            attributes: placeholderAttributes
        )
    }
}
