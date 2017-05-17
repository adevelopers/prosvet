//
//  ViewController.swift
//  Prosvet
//
//  Created by adeveloper on 17.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var uiTable: UITableView!
    var posts:[Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeedFromServer()
    }
    
    func loadFeedFromServer(){
        let model = NetModel()
        model.npGetList({
            posts in
            DispatchQueue.main.async {
                self.posts = posts
                self.uiTable.reloadData()
            }
        })

    }
}


// MARK: - Constants
extension MainVC {
    fileprivate struct Constants {
        static let postCellIdentifier = "PostCell"
        static let postSegueIdentifier = "segueShowPost"
    }
}

//MARK: DataSource
extension MainVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MainCell", owner: self, options: nil)?.first as! MainCell        
        let title = posts[indexPath.row].title
        cell.uiTitle.text = title
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.postSegueIdentifier, sender: posts[indexPath.row])
        
        
    }
    

    
}

// MARK: - Segue
extension MainVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.postSegueIdentifier {
            let controller = segue.destination as! PostDetail
            let post = sender as! Post
            controller.post = post
        }
    }
    
    
}

