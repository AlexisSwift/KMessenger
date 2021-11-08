import Alamofire

final class NetworkRequestManager {
    static var shared = NetworkRequestManager()

    func request<T: Decodable>(
        to api: API,
        parameters: [String: Any],
        completion: @escaping (Result<T, AppError>) -> Void
    ) {
        guard let url = URL(string: api.rawValue) else {
            return completion(.failure(.dataError))
        }
        
        AF.request(url, parameters: parameters).responseJSON { responseJSON in
            switch responseJSON.result {
                case .success:
                    if let data = responseJSON.data,
                       let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(decodedData))
                    } else {
                        completion(.failure(.dataError))
                    }
                case .failure:
                    completion(.failure(.networkError))
            }
        }
    }
}

enum API: String {
    case kodeAPI
    
    public var rawValue: String {
        switch self {
        case .kodeAPI:
            return "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
            
        }
    }
}

enum AppError: Error {
    case networkError
    case dataError
}

