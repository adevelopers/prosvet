//
//  ProsvetTests.swift
//  ProsvetTests
//
//  Created by adeveloper on 17.05.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import XCTest

@testable import Prosvet

class ProsvetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetApi() {
        let api = NetApi.shared
        api.setBase(Constants.baseUrlApi).get(link: "?action=getlist&token=demo"){ json,errors in

            XCTAssertNotNil(json)
            XCTAssertNil(errors)
        }
    }
    
    
    func testNetModel(){
        var items:[Post] = []
        let expect = expectation(description: "Test net Model")
        let model = NetModel()
        model.npGetList({
            posts in
            items = posts
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 4.0, handler: { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            
            let isLoaded:Bool = (items.count > 1)
            XCTAssertTrue(isLoaded)
            if isLoaded == false {
                print("posts: \(items)")
            }
            
        })
    }
    
    
    
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
