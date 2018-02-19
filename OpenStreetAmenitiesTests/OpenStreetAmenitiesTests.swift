//
//  OpenStreetAmenitiesTests.swift
//  OpenStreetAmenitiesTests
//
//  Created by Sam Khawase on 14.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import OpenStreetAmenities

class OpenStreetAmenitiesTests: QuickSpec {
    override func spec() {
        describe("Bootstrap tests") {
            it("should test equality", closure: {
                expect(1 + 1).to(equal(2))
            })
        }
    }
}
