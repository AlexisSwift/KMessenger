final class UserProfileViewModel: ViewModel {
    
    typealias ControllerState = State
    
    @DriverValue private(set) var state: ControllerState
    
    init(userProfile: User, userService: UserServiceAbstract) {
        state = State(userProfile: userProfile)
    }
}

// MARK: - Controller's State
extension UserProfileViewModel {
    final class State {
        @DriverValue fileprivate(set) var userProfile: User = .init(avatarUrl: "",
                                                                    firstName: "",
                                                                    lastName: "",
                                                                    userTag: "",
                                                                    department: "",
                                                                    position: "",
                                                                    birthday: "",
                                                                    phone: "")
        init (userProfile: User) {
            self.userProfile = userProfile
        }
    }
}
