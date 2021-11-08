import UIKit

struct UsersResponse: Decodable {
    let items: [User]
}

struct User: Decodable {
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: String
    let position: String
    let birthday: String
    let phone: String

    enum CodingKeys: String, CodingKey {
        case avatarUrl
        case firstName
        case lastName
        case userTag
        case department
        case position
        case birthday
        case phone
    }
}
