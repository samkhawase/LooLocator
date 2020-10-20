//
//  OSMModelTests.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 20.10.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import Foundation
import Quick
import Nimble

class OSMModelTests: QuickSpec {
    override func spec() {
        var jsonData: Data?
        beforeEach {
            let currentBundle = Bundle(for: type(of: self))
            guard let fileURL = currentBundle.url(forResource: "stubbedRepsonse", withExtension: "json"),
                  let fileContents = try? String(contentsOf: fileURL),
                  let _jsonData = fileContents.data(using: .utf8)
            else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            jsonData = _jsonData
        }
        context("Given a JSON data set") {
            describe("When loading data from json") {
                it("should parse the json to Location Model correctly") {
                    // Arrange
                    let decoder = JSONDecoder()
                    // Act
                    let locations = try? decoder.decode(OSMData.self, from: jsonData!)
                    // Assert
                    expect(locations).toNot(beNil())
                }
            }
        }
    }
}
