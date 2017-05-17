//
//  NetApi.swift
//  iForexLevels
//
//  Created by adeveloper on 17.02.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation
import SwiftyJSON


/**
 *
 *  Singleton
 */
class NetApi {
    
    static let shared = NetApi()
    
    public var baseUrl:String = ""
    
    private init(){
        
    }
    
    func setBase(_ url:String) -> Self {
        baseUrl = url
        return self
    }
    
    func get(link: String, completionHandler: @escaping (JSON, NSError?) -> Void )  {
        
        
        let link = self.baseUrl + link
        print("link: \(link)")
        let url = NSURL(string: link)!
        let request = NSMutableURLRequest(url: url as URL)
        let urlSession = URLSession.init(configuration: URLSessionConfiguration.ephemeral)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request as URLRequest) { data, response, error -> Void in
            if error != nil {
                let json = JSON(data: data!)
                completionHandler(json, error as NSError?)
                return
            }
            
            let json = JSON(data: data!)
            
            completionHandler(json,nil)
            
        }
        task.resume()
    }

    
    func post(link: String, params:String, completionHandler: @escaping (JSON, NSError?) -> Void ) {
        
        let fullLink = self.baseUrl + link
        let url = NSURL(string: fullLink)!
        let request = NSMutableURLRequest(url: url as URL)
        let urlSession = URLSession.shared
        let paramsString = params
        request.httpMethod = "POST"
        request.httpBody = paramsString.data(using: .utf8)
        
        let task = urlSession.dataTask(with: request as URLRequest) { data, response, error -> Void in
            if error != nil {
                let json = JSON(data: data!)
                completionHandler(json, error as NSError?)
                return
            }
            
            let json = JSON(data: data!)
            
            completionHandler(json,nil)
            
        }
        task.resume()
        
    }
    
    
    
    
    
}
