import UIKit
import RxSwift

final class UsersListViewController: UIViewController, UISearchBarDelegate {
    typealias ViewModel = UsersListViewModel
    typealias Event = InputEvent
    
    private var viewModel: ViewModel
    private let disposeBag = DisposeBag()
    private let searchBar = SearchView()
    
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
