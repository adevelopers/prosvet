//
//  NetModel.swift
//  Prosvet
//
//  Created by adeveloper on 19.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation

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

protocol NetProsvetProtocol {
 //   func npGetList((_ onCompletion: @escaping ([Post])->Void )
    func npGetPost(by id:ID,_ onCompletion: @escaping (Post)->Void)
}

struct NetModel: NetProsvetProtocol {
    
    
    enum errors{
        case NO_TOKEN_FILE
        case NO_TOKEN
        case FILE_TOKEN_EXCEPTION
    }
    
    let baseUrl:String = "http://kultprosvetmag.ru/api/v1/"
    var token:String {
        return loadToken()
    }
    
    
    func loadToken() -> String {
        let apiKeyFileName = "token.api"
        let fm = FileManager.default
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if var path = dir.first?.path {
            path += "/" + apiKeyFileName
            
            if fm.fileExists(atPath: path) {
                let urlPath = URL(fileURLWithPath: path)
                do {
                    let apiKey = try String(contentsOf: urlPath, encoding: String.Encoding.utf8)
                    print("api key is: \(apiKey)")
                    return apiKey
                }
                catch  {
                    print(errors.FILE_TOKEN_EXCEPTION)
                }
            }
            else {
                print("api key not found! \(errors.NO_TOKEN_FILE)")
            }
        }
        
        
        return "demo"
    }
    
    
    
    func buildPost() -> Post {
        let post = Post()
        return post
    }
    
    func npGetPost(by id:ID, _ onCompletion: @escaping (Post) -> Void)  {
        let api = NetApi.shared
        api.baseUrl =  self.baseUrl
        var post = Post()
        api.get(link: "?action=getitem&token=\(token)&id=\(id)"){
            json, errors in
            if !json.isEmpty {
                let title = json["NAME"]
                post.title = title.stringValue
            }

            onCompletion(post)
        }

    }

    func npGetList(_ onCompletion: @escaping ([Post])->Void ) {
        
        var posts = [Post]()
        var post = Post()
        NetApi.shared.setBase(self.baseUrl).get(link: "?action=getlist&token=\(token)"){
            json, errors in
            if !json.isEmpty {
                
                for (_, item) in json {
                    let title = item["NAME"].stringValue
                    let text = item["DETAIL_TEXT"].stringValue
                    post.id = Int(item["ID"].description)!
                    post.title = title
                    post.text = text
                    posts.append(post)
                }
                
                onCompletion(posts)
            }
           
        }
        
        
    }

}
