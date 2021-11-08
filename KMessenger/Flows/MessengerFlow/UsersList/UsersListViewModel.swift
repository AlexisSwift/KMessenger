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
        }
    }

    private func loadUsers() {
        userService.getUsers(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.state.users = response.items
                self?.event = .updateUsersList
            case .failure(_):
                break
            }
        })
    }
}

// MARK: - Controller's State
extension UsersListViewModel {
    final class State {
        fileprivate(set) var users: [User] = []
    }
}
