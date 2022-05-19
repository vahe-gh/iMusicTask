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
    
    // MARK: - Properties
    
    static var cellHeight: CGFloat = 84
    var data: TrackItemViewModel? {
        didSet {
            if let data = data {
                updateUI(withData: data)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - UI

private extension TrackTableViewCell {
    
    func updateUI(withData data: TrackItemViewModel) {
//        avatarImageView.load(fromURL: data.avatar, placeholder: "AvatarPlaceholder")
        titleLabel.text = data.title
        artistLabel.text = data.artist
        durationLabel.text = data.playTime
    }
    
}
