//
//  AmenityMocks.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 16.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import Foundation

class MockAmenityRequest: AmenityRequest {
    override func getAmeneties(of type: AmenityType,
                               latitude: Double,
                               longitude: Double,
                               radius: Double,
                               completionBlock: @escaping CompletionBlock) {
        let dummyOSMData = [Location(id: 001, title: "Dummy Amenity", locationDescription: "Dummy Amenity Name", coordintes: (52.51631, 13.37777), isAccessible: false)]
        completionBlock(true, dummyOSMData as AnyObject)
    }
}
