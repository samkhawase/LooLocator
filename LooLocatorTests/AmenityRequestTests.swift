//
//  AmenityRequestTests.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 17.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

import XCTest
import OHHTTPStubs

//@testable import LooLocator

class AmenityRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let testHost = "overpass-api.de"
        stub(condition: isHost(testHost), response: { _ in
            guard let path = OHPathForFile("stubbedRepsonse.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return fixture(filePath: path, status: 200, headers: ["Content-Type":"application/json"])
        })
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let amenityReqeust = AmenityRequest()
        
        let expectation = self.expectation(description: "calls the callback with a resource object")
        
        var successFlag = false
        var locations: [Location] = []
        let timeout = 1.0
        amenityReqeust.getAmeneties(of: AmenityType.Toilets,
                                    latitude: 52.51631,
                                    longitude: 13.37777,
                                    radius: 1000,
                                    completionBlock: { (success, results) in
                                        print("success is \(success)")
                                        successFlag = success
                                        if successFlag, let results = results as? [Location] {
                                            locations = results
                                            expectation.fulfill()
                                        }
        })
        self.waitForExpectations(timeout: timeout) { err in
            XCTAssertNotNil(locations, "Received data should not be nil")
        }
    }
    
    
    
}
