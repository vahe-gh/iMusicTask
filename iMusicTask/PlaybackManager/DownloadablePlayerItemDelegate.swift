//
//  DownloadablePlayerItemDelegate.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 21.05.22.
//

import Foundation

@objc protocol DownloadablePlayerItemDelegate {
    
    /// Is called when the media file is fully downloaded.
    @objc optional func playerItem(_ playerItem: DownloadablePlayerItem, didFinishDownloadingData data: Data)
    
    /// Is called every time a new portion of data is received.
    @objc optional func playerItem(_ playerItem: DownloadablePlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int)
    
    /// Is called after initial pre buffering is finished, means we are ready to play.
    @objc optional func playerItemReadyToPlay(_ playerItem: DownloadablePlayerItem)
    
    /// Is called when the data being downloaded did not arrive in time to continue playback.
    @objc optional func playerItemPlaybackStalled(_ playerItem: DownloadablePlayerItem)
    
    /// Is called on downloading error.
    @objc optional func playerItem(_ playerItem: DownloadablePlayerItem, downloadingFailedWith error: Error)
    
}
