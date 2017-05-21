//
//  Post.swift
//  Prosvet
//
//  Created by adeveloper on 21.05.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

typealias ID = Int
typealias PDate = Date

protocol AuthorProtocol {
    var authorId: ID { get }
    var authorName: String { get set }
}

struct Author: AuthorProtocol {
    var authorName: String
    var authorId: ID
}

protocol PostProtocol
{
    var dataCreate: PDate { get set }
    var title: String { get set }
    var text: String { get set }
    var author: AuthorProtocol {get set}
    var numberOfRead: Int { get }

}



struct Post: PostProtocol {
    var id:ID
    var title: String
    var author: AuthorProtocol
    var text: String
    var dataCreate: PDate
    
    init(){
        self.id = 0
        self.title = ""
        self.text = ""
        let newAuthor = Author(authorName: "Кирилл", authorId: 1)
        let date: PDate = PDate(timeIntervalSinceNow: 10)
        self.dataCreate = date
        self.author = newAuthor
        self.numberOfRead = 0
    }
    
    internal var numberOfRead: Int
}
