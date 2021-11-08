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

        router.setRootModule(controller)
    }

    func showKittiesListScreen() {
    }
}
