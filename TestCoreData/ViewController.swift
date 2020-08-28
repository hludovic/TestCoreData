//
//  ViewController.swift
//  TestCoreData
//
//  Created by Ludovic HENRY on 28/08/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var posts: [Post] = Post.all
    var refreshControl =  UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddPostButton))
        navigationItem.rightBarButtonItem = addButton
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefreshTableView), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    func downloadPosts() {
        PostWebService.getPosts { (success, result) in
            guard success, let result = result else {
                DispatchQueue.main.async {
                }
                return
            }
            
            DispatchQueue.main.async {
                for postResult in result {
                    let post = Post(context: AppDelegate.viewContext)
                    post.body = postResult.body
                    post.title = postResult.title
                    post.id = Int16(postResult.id)
                    post.userId = Int16(postResult.userId)
                    self.posts.append(post)
                }
                try? AppDelegate.viewContext.save()
            }
        }
    }
    
        
    @objc private func pressAddPostButton() {
        if let vc = storyboard?.instantiateViewController(identifier: "AddPost") as? AddPostViewController {
            vc.refreshDelegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func pullToRefreshTableView(_ sender: AnyObject) {
        downloadPosts()
        refreshData()
        refreshControl.endRefreshing()
    }

}

extension ViewController: RefreshDelegate {
    func refreshData() {
        posts = Post.all
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
    
}

