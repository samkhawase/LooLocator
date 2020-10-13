//
//  ApiClientTests.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 17.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

import XCTest
import Quick
import Nimble
import CoreLocation
import OHHTTPStubs
import OHHTTPStubsSwift


class ApiClientTests: QuickSpec {
    override func spec() {
        describe("Amenity Request tests") {
            let amenityReqeust = AmenityRequest()
            
            beforeEach {
                let testHost = "overpass-api.de"
                stub(condition: isHost(testHost), response: { _ in
                    guard let path = OHPathForFile("stubbedRepsonse.json", type(of: self)) else {
                        preconditionFailure("Could not find expected file in test bundle")
                    }
                    return fixture(filePath: path, status: 200, headers: ["Content-Type":"application/json"])
                })
            }
            afterEach {
                HTTPStubs.removeAllStubs()
            }
            
            it("should fetch amenities", closure: {
                // Arrange
                var successFlag = false
                var locations: [Location] = []
                // Act
                amenityReqeust.getAmeneties(of: AmenityType.Toilets,
                                            latitude: 52.51631,
                                            longitude: 13.37777,
                                            radius: 1000,
                                            completionBlock: { (success, results) in
                                                successFlag = success
                                                if successFlag, let results = results as? [Location] {
                                                    locations = results
                                                }
                })
                
                //Assert
                expect(successFlag).toEventuallyNot(beFalse())
                expect(locations).toEventuallyNot(beEmpty())
                
                expect(locations.first?.id).toEventuallyNot(beEmpty())
                expect(locations.first?.coordinates.0).toEventuallyNot(equal(0))
                expect(locations.first?.coordinates.1).toEventuallyNot(equal(0))
            })
        }
    }
}
