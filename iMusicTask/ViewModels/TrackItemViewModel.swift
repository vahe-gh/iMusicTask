//
//  TrackItemViewModel.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 18.05.22.
//

import Foundation

enum PlaybackState {
    case stopped, playing, paused
}

class TrackItemViewModel {
    let id: Int
    let title: String
    let artist: String
    let playTime: String
    let downloadURL: URL?
    var playbackState: PlaybackState = .stopped
    var localFileURL: URL? {
        LocalStorageManager.shared.getFileURL(itemId: "\(id)", folder: "songs")
    }
    
    var isDownloaded: Bool = false
//    var downloadButtonState: DownloadState = .downloadable
    
    func setAsDownloaded() {
        isDownloaded = true
        print("Set as downloaded")
    }
    
    func removeDownloaded() {
        isDownloaded = false
        print("Remove downloaded")
    }
    
    private func checkIfDownloaded() {
        DispatchQueue.global().async {
            guard let url = self.localFileURL else {
                self.isDownloaded = false
                return
            }
            
            self.isDownloaded = LocalStorageManager.shared.isFileExist(url: url)
        }
    }
    
    internal init(id: Int, title: String, artist: String, playTime: String, downloadURL: URL?, playbackState: PlaybackState = .stopped, isDownloaded: Bool = false) {
        self.id = id
        self.title = title
        self.artist = artist
        self.playTime = playTime
        self.downloadURL = downloadURL
        self.playbackState = playbackState
        self.isDownloaded = isDownloaded
        
        checkIfDownloaded()
    }
    
}
