//
//  TrackTableViewCell.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playbackButton: UIButton!
    
    // MARK: - Public properties
    
    static var cellHeight: CGFloat = 84
    var data: TrackItemViewModel? {
        didSet {
            if let data = data {
                updateUI(withData: data)
            }
        }
    }
    
    // MARK: - Private properties
    
//    private var playbackState: PlaybackState = .stopped
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - User interaction
    
    @IBAction func playbackButtonTapped(_ sender: Any) {
        guard let data = data else {
            return
        }
        
        if data.playbackState == .playing {
            self.data?.playbackState = .paused
        } else {
            self.data?.playbackState = .playing
        }
        
        updateButtonState()
    }
    
}

// MARK: - UI

private extension TrackTableViewCell {
    
    func updateUI(withData data: TrackItemViewModel) {
        titleLabel.text = data.title
        artistLabel.text = data.artist
        durationLabel.text = data.playTime
        updateButtonState()
    }
    
    func updateButtonState() {
        guard let data = data else {
            return
        }
        
        if data.playbackState == .playing {
            playbackButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        } else {
            playbackButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }
    }
    
}
