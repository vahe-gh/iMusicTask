//
//  LoginViewController.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dataSource = UserViewModel()
//    private let refreshControl = UIRefreshControl()
    private let detailSegue = "showTracks"

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
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

// MARK: - UpdateUIDelegate

extension LoginViewController: UpdateUIDelegate {
    
    func updateUI(error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.showOkAlert(title: "", message: error.localizedDescription)
            }
            
            return
        }
        
        reloadDataView()
    }
    
}

private extension LoginViewController {
    
    func initialSetup() {
        dataSource.delegate = self
//        refreshControl.center = self.view.center
    }
    
//    func showActivityIndicatory() {
////        var activityView = UIActivityIndicatorView(style: .large)
//        activityView.center = self.view.center
//        self.view.addSubview(activityView)
//        activityView.startAnimating()
//    }
    
}

// MARK: - Data management

private extension LoginViewController {
    
    /// Fetch data from remote
    func retrieveData() {
//        refreshControl.beginRefreshing()
//        self.setContentOffset(CGPoint(x: 0, y: self.contentOffset.y - (refreshControl.frame.size.height)), animated: true)
        dataSource.getData(username: "465a4fafa45sfa46")
    }
    
    /// Update local data after fetching from remote
    private func reloadDataView() {
        DispatchQueue.main.async {
//            self.refreshControl.endRefreshing()
            self.performSegue(withIdentifier: self.detailSegue, sender: nil)
        }
    }
    
}
