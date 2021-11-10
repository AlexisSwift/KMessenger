import UIKit
import RxSwift

final class UsersListViewController: UIViewController {
    typealias ViewModel = UsersListViewModel
    typealias Event = InputEvent
    
    private(set) var state = State()
    
    private var viewModel: ViewModel
    private let disposeBag = DisposeBag()
    
    private let searchBar = UISearchBar()
    private let tableContainer = BaseTableContainerView()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupView()
        setupBindings()
        
        viewModel.handle(.load)
    }
    
    private func setupView() {
        self.view.background(.white)
        
        setupSearchBar()
        
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
        case .updateUsersList:
            buildTable(source: viewModel.state.users)
        case .none:
            break
        }
    }
}

// MARK: - UI
extension UsersListViewController {
    private func body(state: ViewModel.State) -> UIView {
        VStack {
            searchBar
            tableContainer
        }
        .layoutMargins(hInset: 16)
    }
}

// MARK: - Search
extension UsersListViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchBar.delegate = self
        
        searchBar.barTintColor = .white
        searchBar.cornerRadius(16)
        searchBar.placeholder = "Введи имя, тег, почту..."
        searchBar.placeholderLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        searchBar.tintColor = Palette.colorAccent
        searchBar.searchField?.textColor = .black
        searchBar.searchBarStyle = .minimal
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        state.filteredUsers = []
        
        guard searchText != "" else {
            state.filteredUsers = viewModel.state.users
            buildTable(source: state.filteredUsers)
            return
        }
        
        for user in viewModel.state.users {
            if user.firstName.lowercased().contains(searchText.lowercased()) ||
                user.lastName.lowercased().contains(searchText.lowercased()) ||
                user.userTag.lowercased().contains(searchText.lowercased())
            {
                state.filteredUsers.append(user)
            }
        }
        buildTable(source: state.filteredUsers)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

// MARK: - Table
private extension UsersListViewController {
    func setupTableView() {
        tableContainer.register(cellModels: [UserCellViewModel.self])
    }
    
    func buildTable(source: [User]) {
        var items: [CellViewModel] = []
        source.forEach { user in
            items.append(SpacerCellViewModel(height: 12))
            items.append(UserCellViewModel(source: user))
        }
        items.append(SpacerCellViewModel(height: 12))
        tableContainer.tableManager.set(items: items)
    }
}

extension UsersListViewController {
    final class State {
        var filteredUsers:[User] = []
    }
}

// MARK: - Action, Event
extension UsersListViewController {
    enum Action {
        case load
    }
    
    enum InputEvent {
        case none
        case updateUsersList
    }
}
