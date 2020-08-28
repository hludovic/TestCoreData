//
//  AddPostViewController.swift
//  TestCoreData
//
//  Created by Ludovic HENRY on 28/08/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func savePost() {
        guard let title = titleTextField.text, let body = bodyTextField.text else {
            return
        }
        
        let post = Post(context: AppDelegate.viewContex)
        post.body = body
        post.title = title
        post.userId = 1
        post.id = 1
        
        try? AppDelegate.viewContex.save()
        
    }
    
    @IBAction func savePostButton(_ sender: UIButton) {
        savePost()
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
