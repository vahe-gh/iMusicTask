//
//  Track.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 18.05.22.
//

import Foundation

struct Track {
    let id: Int
    let title: String
    let artist: String
    let play_time: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, artist, url
        case playTime = "play_time"
    }
}
