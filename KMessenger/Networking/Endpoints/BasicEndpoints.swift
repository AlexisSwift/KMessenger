import Alamofire

enum BasicEndpoints {
    case getUsers
}

extension BasicEndpoints: Target {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: AppSettings.API.test.rawValue)!
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var keyPath: String? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
}
