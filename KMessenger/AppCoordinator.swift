import UIKit

final class AppCoordinator: BaseCoordinator {
    private(set) var router: RouterAbstract

    init(
        router: RouterAbstract
    ) {
        self.router = router
    }

    override func start() {
        showSearchScreen()
    }
}

private extension AppCoordinator {
    func showSearchScreen() {
        let viewModel = UsersListViewModel(userService: UserService())
        let controller = UsersListViewController(viewModel: viewModel)

        controller.onUserProfileScreen = { [weak self] in
            self?.showUserProfileScreen(user: $0)
        }
        
        router.setRootModule(controller)
    }

    func showUserProfileScreen(user: User) {
        let viewModel = UsersListViewModel(userService: UserService())
        let controller = UserProfileViewController(viewModel: viewModel)

        router.push(controller)
    }
}
