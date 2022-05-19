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

struct TrackItemViewModel {
    let title: String
    let artist: String
    let playTime: String
    let url: URL?
    var playbackState: PlaybackState = .stopped
}
