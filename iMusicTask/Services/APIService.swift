//
//  APIService.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 18.05.22.
//

import Foundation

enum APIEndpoint {
    case register
    case getTracks
    
    var url: URL {
        switch self {
        case .register:
            return URL(string: "https://api.im.am/test/register")!
        case .getTracks:
            return URL(string: "https://api.im.am/test/get-tracks")!
        }
    }
    
    var urlString: String {
        switch self {
        case .register:
            return "https://api.im.am/test/register"
        case .getTracks:
            return "https://api.im.am/test/get-tracks"
        }
    }
}

class APIService: NSObject {
    
    private var token: String?
    
    // MARK: - Singletone
    
    static let shared = APIService()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Requests
    
    func fetchData<T: Decodable>(request: HTTPRequest, model: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        if request.withToken {
            request.addParameter(name: "token", value: token ?? "")
        }
        
        URLSession.shared.dataTask(with: request.urlRequest()) { (data, urlResponse, error) in
            if let data = data {
                do {
                    let modelData = try JSONDecoder().decode(model.self, from: data)
                    completion(.success(modelData))
                } catch (let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(AppError.unknownError))
                }
            }
            
        }.resume()
    }
    
}

// MARK: - Token management

extension APIService {
    
    func updateToken(withValue value: String) {
        token = value
    }

}
