//
//  ErrHandle.swift
//  Prosvet
//
//  Created by adeveloper on 18.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation

enum ErrorsE: Error {
    case System
    case User
    case Background
}

class Handle {
    func save() throws {
        for i in 1...3 {
            if i == 2 {
                throw ErrorsE.User
            }
        }
        
    }
}

class AppHandle {
    
    func run(){
        let e = Handle()
        do {
          try  e.save()
        }
        catch let error {
            print("error: \(error)")
        }
    }
}
