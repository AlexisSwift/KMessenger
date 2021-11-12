import Foundation

protocol UserServiceAbstract {
    func getUsers(completion: @escaping (Result<UsersResponse, AppError>) -> Void)
}

final class UserService: UserServiceAbstract {
    func getUsers(completion: @escaping (Result<UsersResponse, AppError>) -> Void) {
        NetworkRequestManager.shared.request(
            to: .kodeAPI,
            parameters: [:],
            completion: completion
        )
    }
}
