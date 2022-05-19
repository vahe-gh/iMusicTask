//
//  TrackViewModel.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 18.05.22.
//

import Foundation

class TrackViewModel {
    
    // MARK: - Private properties
    
    private var modelData: [Track]?
    
    // MARK: - Public properties
    
    var data = [TrackItemViewModel]()
    weak var delegate: UpdateUIDelegate?
    
    // MARK: - Data operations
    
    func getData() {
        let request = HTTPRequest(
            endpoint: APIEndpoint.getTracks.urlString,
            method: .get,
            parameters: nil,
            withToken: true)
        
        APIService.shared.fetchData(request: request, model: [Track].self) { result in
            switch result {
            case .success(let data):
                self.data = data.map({ self.createViewModel(from: $0) })
                self.delegate?.updateUI(error: nil)
            case .failure(let error):
                self.delegate?.updateUI(error: error)
            }
        }
    }
    
}

private extension TrackViewModel {
    
    func createViewModel(from data: Track) -> TrackItemViewModel {
        let url = URL(string: data.url)
        let itemViewModel = TrackItemViewModel(
            title: data.title,
            artist: data.artist,
            playTime: data.playTime.secondsToTime(),
            url: url
        )
        return itemViewModel
    }
    
}
