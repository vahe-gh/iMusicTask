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
//    var reloadUI: ((Error?) -> ())?
    weak var delegate: UpdateUIDelegate?
    
    // MARK: - Data operations
    
    func getData() {
        
    }
    
}
