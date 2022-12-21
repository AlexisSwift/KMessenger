final class UsersListViewModel: ViewModel {

    typealias ControllerState = State
    typealias OutputEvent = UsersListViewController.InputEvent
    typealias InputAction = UsersListViewController.Action

    @DriverValue private(set) var state: ControllerState
    @DriverValue private(set) var event: OutputEvent = .none
    
    private let userService: UserServiceAbstract

    init(userService: UserServiceAbstract) {
        state = State()
        self.userService = userService
        
        super.init()
    }

    func handle(_ action: InputAction) {
        switch action {
        case .load:
            loadUsers()
        case let .search(text):
            search(searchText: text)
        }
    }

    private func loadUsers() {
        userService.getUsers(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.state.users = response.items
                self?.event = .updateUsersList(users: response.items)
            case .failure(_):
                break
            }
        })
    }
    
    private func search(searchText: String) {
        state.filteredUsers = []
        
        guard searchText != "" else {
            state.filteredUsers = state.users
            event = .updateUsersList(users: state.filteredUsers)
            return
        }
        
        for user in state.users where
        user.firstName.lowercased().contains(searchText.lowercased()) ||
        user.lastName.lowercased().contains(searchText.lowercased()) ||
        user.userTag.lowercased().contains(searchText.lowercased()) {
            state.filteredUsers.append(user)
        }
        
        event = .updateUsersList(users: state.filteredUsers)
    }
}

// MARK: - Controller's State
extension UsersListViewModel {
    final class State {
        @DriverValue fileprivate(set) var users: [User] = []
        fileprivate(set) var filteredUsers: [User] = []
    }
}
