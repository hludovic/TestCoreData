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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddPostButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func pressAddPostButton() {
        if let vc = storyboard?.instantiateViewController(identifier: "AddPost") as? AddPostViewController {
            vc.modalPresentationStyle = .automatic
            present(vc, animated: true, completion: nil)
        }
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

