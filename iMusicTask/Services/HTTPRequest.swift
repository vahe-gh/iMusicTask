//
//  HTTPRequest.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import Foundation

typealias HTTPRequestParameters = [String: Any]

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class HTTPRequest {
    
    // MARK: - Properties
    
    let endpoint: String
    let method: HTTPRequestMethod
    private var parameters: HTTPRequestParameters?
    let withToken: Bool
    
    // MARK: - Lifecycle
    
    init(endpoint: String, method: HTTPRequestMethod,  parameters: HTTPRequestParameters?, withToken: Bool) {
        self.endpoint = endpoint
        self.method = method
        self.withToken = withToken
        self.parameters = parameters
    }
    
}

// MARK: - Public Functions

extension HTTPRequest {
    
    func addParameter(name: String, value: Any) {
        if parameters == nil {
            parameters = HTTPRequestParameters()
        }
        
        parameters![name] = value
    }
    
    func urlRequest() -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            if method == .post {
                /// Add request parameters in body
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                } catch let error {
                    print("Request body parse error: \(error.localizedDescription)")
                }
            } else if method == .get || method == .delete {
                /// Add request parameters to url
                var components = URLComponents()
                components.scheme = request.url?.scheme
                components.host = request.url?.host
                components.path = request.url?.path ?? ""
                components.queryItemsDictionary = parameters

                print(components.url ?? "")
                request.url = components.url
            }
        }
        
//        for header in headers {
//            request.addValue(header.value, forHTTPHeaderField: header.key)
//        }
//        request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        if let body = requestBody {
//            request.httpBody = body
//        } else if method == .post {
//            /// Add request parameters in body
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//            } catch let error {
//                LogManager.e("Request body parse error: \(error.localizedDescription)")
//            }
//        } else if method == .get || method == .delete {
//            /// Add request parameters in url
//            if let parameters = parameters {
//                var components = URLComponents()
//                components.scheme = request.url?.scheme
//                components.host = request.url?.host
//                components.path = request.url?.path ?? ""
//                components.queryItemsDictionary = parameters
//    //            for (key, value) in parameters {
//    //                components.queryItems?.append(URLQueryItem(name: key, value: value as? String))
//    //            }
//                print(components.url ?? "")
//                request.url = components.url
//            }
////            request.url?.appendPathComponent(components.url?.absoluteString ?? "", isDirectory: false)
////            components.b
////                components.queryItems = [
////                    URLQueryItem(name: "q", value: query),
////                    URLQueryItem(name: "sort", value: sorting.rawValue)
////                ]
//        }

        
//        print("Generated URL is \(String(describing: request.url))")
        return request
    }
    
}
