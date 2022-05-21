//
//  TracksTableViewController.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import UIKit
import AVFoundation

class TracksTableViewController: UITableViewController {

    // MARK: - Private properties
    
    private let dataSource = TrackViewModel()
    private var playingIndexPath: IndexPath?
    private var player: AVPlayer?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        retrieveData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension TracksTableViewController {
    
    func initialSetup() {
        dataSource.delegate = self
    }
    
}

// MARK: - TableView delegates

extension TracksTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TrackTableViewCell.cellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reusableId, for: indexPath) as? TrackTableViewCell else {
            return UITableViewCell()
        }
        
        cell.data = dataSource.data[indexPath.row]
        cell.delegate = self
        cell.indexPath = indexPath

        /// Configure the cell
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - Setup controls

extension TracksTableViewController {
    
    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.prefetchDataSource = self
//        tableView.addSubview(refreshControl)
        
        // Register table view cells
        tableView.register(UINib(nibName: TrackTableViewCell.reusableId, bundle: nil), forCellReuseIdentifier: TrackTableViewCell.reusableId)
//        tableView.register(UINib(nibName: LoadingTableViewCell.reusableId, bundle: nil), forCellReuseIdentifier: LoadingTableViewCell.reusableId)

        refreshControl?.addTarget(self, action: #selector(retrieveData), for: .valueChanged)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Tracks"
    }
    
}

// MARK: - Data management

extension TracksTableViewController {
    
    /// Fetch data from remote
    @objc private func retrieveData() {
        refreshControl?.beginRefreshing()
        dataSource.getData()
    }
    
}

// MARK: - UpdateUIDelegate

extension TracksTableViewController: UpdateUIDelegate {
    
    func updateUI(error: Error?) {
        DispatchQueue.main.async { [weak self] in
//            self?.refreshControl?.endRefreshing()
            if let error = error {
                self?.showOkAlert(title: "", message: error.localizedDescription)
                return
            }
        
            if self?.dataSource.data.count == 0 {
                self?.showOkAlert(title: "", message: "There are no tracks!")
            }
            self?.tableView.reloadData()
        }
    }
    
}

extension TracksTableViewController: DownloadablePlayerItemDelegate {
    
    func playerItem(_ playerItem: DownloadablePlayerItem, didFinishDownloadingData data: Data) {
        guard let indexPath = playingIndexPath,
              let saveTo = dataSource.data[indexPath.row].localFileURL else {
            return
        }
        
        dataSource.data[indexPath.row].setAsDownloaded()
        LocalStorageManager.shared.saveDataToFile(data: data, saveTo: saveTo)
    }
     
}

private extension TracksTableViewController {
    
    func playFromLocal(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func playFromRemote(url: URL) {
        let playerItem = DownloadablePlayerItem(url: url)
        playerItem.delegate = self
        player = AVPlayer(playerItem: playerItem)
        player?.automaticallyWaitsToMinimizeStalling = false
        player?.play()
    }
    
    func pausePreviousPlayback(at indexPath: IndexPath?) {
        guard let player = player else {
            return
        }
        
        if player.rate == 0 {
            return
        }
        
        player.pause()
        
        guard let indexPath = indexPath, let playingCell = tableView.cellForRow(at: indexPath) as? TrackTableViewCell else {
            return
        }
        dataSource.data[indexPath.row].playbackState = .stopped
        playingCell.data = dataSource.data[indexPath.row]
    }
    
}

extension TracksTableViewController: PlaybackDelegate {
    
    func play(at indexPath: IndexPath) {
        guard playingIndexPath != indexPath else {
            continuePlayback()
            return
        }
        pausePreviousPlayback(at: playingIndexPath)
        playingIndexPath = indexPath
        
        let data = dataSource.data[indexPath.row]
        guard let downloadURL = data.downloadURL, let localURL = data.localFileURL else {
            return
        }
        
        if data.isDownloaded {
            playFromLocal(url: localURL)
        } else {
            playFromRemote(url: downloadURL)
        }
    }
    
    func continuePlayback() {
        player?.play()
    }
    
    func pause(at indexPath: IndexPath) {
        player?.pause()
    }
    
}
