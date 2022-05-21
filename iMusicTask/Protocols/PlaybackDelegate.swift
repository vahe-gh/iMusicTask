//
//  PlaybackDelegate.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 20.05.22.
//

import Foundation

protocol PlaybackDelegate: AnyObject {
    func play(at indexPath: IndexPath)
    func pause(at indexPath: IndexPath)
}
