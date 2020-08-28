//
//  PostWebService.swift
//  TestCoreData
//
//  Created by Ludovic HENRY on 28/08/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import Foundation

class PostWebService {
    
    static func getPosts(callback: @escaping (Bool, [Response]?) ->Void ) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            guard let postsJson = try? JSONDecoder().decode([Response].self, from: data) else {
                callback(false, nil)
                return
            }
            
            callback(true, postsJson)
            
        }
        task.resume()
        
    }
}

struct Response: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
}
