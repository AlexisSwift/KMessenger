import SnapKit

final class SearchView: UIView, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    
    init() {
        super.init(frame: .zero)
        setupSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        //        state.filteredUsers = state.users
        searchBar.delegate = self
        
        searchBar.barTintColor = .white
        searchBar.layer.cornerRadius = 16
        searchBar.placeholder = "Введи имя, тег, почту..."
        searchBar.placeholderLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        searchBar.tintColor = .gray
        searchBar.searchField?.textColor = .black
        searchBar.searchBarStyle = .minimal
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.right.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
