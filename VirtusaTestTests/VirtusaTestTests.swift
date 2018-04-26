//
//  VirtusaTestTests.swift
//  VirtusaTestTests
//
//  Created by Wael Saad on 26/4/18.
//  Copyright © 2018 nettrinity.com.au. All rights reserved.
//

import XCTest
@testable import VirtusaTest

class VirtusaTestTests: XCTestCase {
    
    var responseData: Data!
    
    override func setUp() {
        super.setUp()

        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Facts", ofType: "json")
        responseData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    }
    
    override func tearDown() {
        responseData = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUrlRequestReturnsTheCorrectHttpMethod() {
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let urlRequest = url.urlRequest()
        let expectedHttpMethod = "GET"
        XCTAssertEqual(urlRequest.httpMethod, expectedHttpMethod)
    }
    
    func testFact() {
        let fact = Fact(jsonDictionary: try! JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as! [String : Any])
        XCTAssertNotNil(fact)
        XCTAssertTrue(fact.title == "About Canada")
    }

}
