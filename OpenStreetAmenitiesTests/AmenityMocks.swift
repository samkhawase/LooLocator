//
//  AmenityMocks.swift
//  OpenStreetAmenitiesTests
//
//  Created by Sam Khawase on 16.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Foundation
@testable import OpenStreetAmenities

class MockAmenityRequest: AmenityRequest {
    
    internal var callCount = 0
    
    override func getAmeneties(of type: AmenityType,
                               latitude: Double,
                               longitude: Double,
                               radius: Double,
                               completionBlock: @escaping CompletionBlock) {
        callCount += 1
        let dummyOSMData = [Location(id: "DummyLocation001", title: "Dummy Amenity", locationName: "Dummy Amenity Name", coordintes: (52.51631, 13.37777), isAccessible: false)]
        completionBlock(true, dummyOSMData as AnyObject)
    }
    
    override func get(request: NSMutableURLRequest, completion: @escaping CompletionBlock) {
        callCount += 1
    }
    
    override func post(request: NSMutableURLRequest, completion: @escaping CompletionBlock) {
        callCount += 1
    }
    
    override func put(request: NSMutableURLRequest, completion: @escaping CompletionBlock) {
        callCount += 1
    }
    
    override func delete(request: NSMutableURLRequest, completion: @escaping CompletionBlock) {
        callCount += 1
    }
    
    override func createURLRequest<T>(from resource: T) -> NSMutableURLRequest? where T : ApiResourceProviding {
        return NSMutableURLRequest()
    }
    
    typealias SerializedType = RawOSMData
    
    
}
