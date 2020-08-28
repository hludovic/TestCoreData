//
//  PostWebService.swift
//  TestCoreData
//
//  Created by Ludovic HENRY on 28/08/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import Foundation

class PostWebService {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let session = URLSession(configuration: .default)
    
    func getPosts(callback: @escaping (Bool, [Post]) ->Void ) {
        //
    }
}
