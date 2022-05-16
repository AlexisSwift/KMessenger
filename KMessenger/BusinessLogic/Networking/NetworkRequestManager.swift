import Alamofire

final class NetworkRequestManager {
    static var shared = NetworkRequestManager()

    func request<T: Decodable>(
        _ target: Target,
        completion: @escaping (Result<T, AppError>) -> Void
    ) {
        
        let afRequest = AF.request(
            target.urlPath,
            method: target.method,
            parameters: target.parameters,
            headers: NetworkRequestManager.headers(targetHeaders: target.headers)
        )
        
        afRequest.responseJSON { responseJSON in
            print("\nRequest for \"\(responseJSON.request?.debugDescription ?? "")\":\n", afRequest.cURLDescription())
            switch responseJSON.result {
                case .success:
                if let debugData = responseJSON.value {
                    print("\nResponse for \"\(responseJSON.request?.debugDescription ?? "")\":\n", debugData)
                }
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
    
    class func headers(targetHeaders: [String: String]?) -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        
        headers["Content-Type"] = "application/json"
        
        if let targetHeaders = targetHeaders {
            for (key, value) in targetHeaders {
                headers[key] = value
            }
        }
        
        return headers
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

