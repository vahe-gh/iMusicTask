//
//  URLComponents+Extensions.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import Foundation

extension URLComponents {
    
    var queryItemsDictionary: [String: Any] {
        set (queryItemsDictionary) {
            self.queryItems = queryItemsDictionary.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
        }
        get {
            var params = [String: Any]()
            return queryItems?.reduce([:], { (_, item) -> [String: Any] in
                params[item.name] = item.value
                return params
            }) ?? [:]
        }
    }
    
}
