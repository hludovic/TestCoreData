//
//  Post.swift
//  TestCoreData
//
//  Created by Ludovic HENRY on 28/08/2020.
//  Copyright © 2020 Ludovic HENRY. All rights reserved.
//

import Foundation
import CoreData

class Post: NSManagedObject {
    static var all: [Post] {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        guard let posts = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return posts
    }
}
