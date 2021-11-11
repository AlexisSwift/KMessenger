import UIKit

final class AppCoordinator: BaseCoordinator {
    private(set) var router: RouterAbstract

    init(
        router: RouterAbstract
    ) {
        self.router = router
    }

    override func start() {
        showUserListScreen()
    }
}

private extension AppCoordinator {
    func showUserListScreen() {
        let viewModel = UsersListViewModel(userService: UserService())
        let controller = UsersListViewController(viewModel: viewModel)

        controller.onUserProfileScreen = { [weak self] user in
            self?.showUserProfileScreen(user: user)
        }
        
        router.setRootModule(controller)
    }

    func showUserProfileScreen(user: User) {
        let viewModel = UserProfileViewModel(userProfile: user, userService: UserService())
        let controller = UserProfileViewController(viewModel: viewModel)

        router.push(controller)
    }
}
