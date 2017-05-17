//
//  ViewController.swift
//  TableViewDetail
//
//  Created by adeveloper on 20.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit




class PostList: UIViewController {

    //typealias Post = String
    @IBOutlet weak var uiTable: UITableView!
    
    var posts:[Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uiTable.delegate = self
        uiTable.dataSource = self
        self.loadPosts()
    }

    
    func loadPosts(){
        
        posts.append(Post())
        posts.append(Post())
        posts.append(Post())
        posts.append(Post())
    }
    

}
// MARK: - Constants
extension PostList {
    fileprivate struct Constants {
        static let PostCellIdentifier = "PostCell"
        static let PostSegueIdentifier = "ShowPost"
    }
}

// MARK: - UITableViewDataSource
extension PostList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MainCell", owner: self, options: nil)?.first as! MainCell
//        let cell =  uiTable.dequeueReusableCell(withIdentifier: Constants.PostCellIdentifier) as! MainCell
        
        let title = posts[indexPath.row].title
        cell.uiTitle.text = title
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PostList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowPost", sender: posts[indexPath.row])
        
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
}

// MARK: - Segue
extension PostList {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.PostSegueIdentifier {
            let controller = segue.destination as! PostDetail
            let post = sender as! Post
            controller.post = post
            print("sender:  \(post)")
        }
    }
    

}


