//
//  UserViewModel.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import Foundation

class UserViewModel {
    
    // MARK: - Private properties
    
    private var modelData: User?
//    private let username = "465a4fafa45sfa46"
    
    // MARK: - Public properties
    
    var data: UserItemViewModel?
//    var reloadUI: ((Error?) -> ())?
    weak var delegate: UpdateUIDelegate?
    
    // MARK: - Data operations
    
    func getData(username: String) {
        let parameters = ["uuid": username]
        let request = HTTPRequest(
            endpoint: APIEndpoint.register.urlString,
            method: .post,
            parameters: parameters,
            withToken: false)
        
        APIService.shared.fetchData(request: request, model: User.self) { result in
            switch result {
            case .success(let data):
                self.data = UserItemViewModel(token: data.token)
                APIService.shared.updateToken(withValue: data.token)
                self.delegate?.updateUI(error: nil)
            case .failure(let error):
                self.delegate?.updateUI(error: error)
            }
        }
    }
    
}
