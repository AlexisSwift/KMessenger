import Foundation

protocol UserServiceAbstract {
    func getUsers(completion: @escaping (Result<UsersResponse, AppError>) -> Void)
}

final class UserService: UserServiceAbstract {
    func getUsers(completion: @escaping (Result<UsersResponse, AppError>) -> Void) {
        NetworkRequestManager.shared.request(
            to: .kodeAPI,
            parameters: ["amount":"\(Constant.nekosCount)"],
            completion: completion
        )
    }
}

extension UserService {
    private enum Constant {
        static let nekosCount = 10
    }
}
