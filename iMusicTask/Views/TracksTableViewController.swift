//
//  TracksTableViewController.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import UIKit

class TracksTableViewController: UITableViewController {

    // MARK: - Properties
    
    private let dataSource = TrackViewModel()
    
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

        /// Configure the cell
        cell.selectionStyle = .none
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
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
