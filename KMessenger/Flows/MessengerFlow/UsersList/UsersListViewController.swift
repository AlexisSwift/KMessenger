import RxSwift

final class UsersListViewController: UIViewController {
    typealias ViewModel = UsersListViewModel
    typealias Event = InputEvent
    
    private var viewModel: ViewModel
    private let disposeBag = DisposeBag()
    
    private let searchBar = SearchBar()
    private let tableContainer = BaseTableContainerView()
    
    lazy private var refreshControl = UIRefreshControl()
    
    // MARK: - Handler
    var onUserProfileScreen: UserHandler?
    var popUpFilter: VoidHandler?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel.handle(.load)
    }
    
    private func setupView() {
        title = L10n.homeTitle()
        navigationItem.titleView = searchBar
        view.background(.white)
        
        setupSearchBar()
        setupTableView()
        
        self.viewModel.$state
            .drive { [weak self] state in
                guard let self = self else { return }
                
                self.body(state: state).embedIn(self.view)
            }.disposed(by: disposeBag)
    }
    
    private func setupBindings() {
        viewModel.$event.drive { [weak self] event in
            self?.handle(event)
        }
        .disposed(by: disposeBag)
    }
    
    func handle(_ event: Event) {
        switch event {
        case let .updateUsersList(users):
            buildTable(source: users)
        case .none:
            break
        }
    }
}

// MARK: - UI
private extension UsersListViewController {
    private func body(state: ViewModel.State) -> UIView {
        VStack {
            tableContainer
        }
        .layoutMargins(hInset: 16)
    }
}

// MARK: - Search
extension UsersListViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.handle(.search(text: searchText))
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        popUpFilter?()
    }
}

// MARK: - Table
private extension UsersListViewController {
    func setupTableView() {
        tableContainer.tableView.showsVerticalScrollIndicator = true
        tableContainer.register(cellModels: [UserCellViewModel.self])
        refreshAction()
    }
    
    func buildTable(source: [User]) {
        var items: [CellViewModel] = []
        source.forEach { user in
            items.append(SpacerCellViewModel(height: 12))
            
            let userCellViewModel = UserCellViewModel(source: user)
            userCellViewModel.onUserProfileScreen = { [weak self] in
                self?.onUserProfileScreen?($0)
            }
            
            items.append(userCellViewModel)
        }
        items.append(SpacerCellViewModel(height: 12))
        tableContainer.tableManager.set(items: items)
    }
    
    private func refreshAction() {
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        tableContainer.tableView.addSubview(refreshControl)
    }
}

// MARK: - @objc func
@objc
private extension UsersListViewController {
    private func pullToRefresh(_ sender: AnyObject) {
        viewModel.handle(.load)
        sender.endRefreshing()
    }
}

// MARK: - Action, Event
extension UsersListViewController {
    enum Action {
        case load
        case search(text: String)
    }
    
    enum InputEvent {
        case none
        case updateUsersList(users: [User])
    }
}
