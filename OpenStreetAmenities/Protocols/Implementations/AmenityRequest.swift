//
//  AmenityRequest.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Foundation

class AmenityRequest: NetworkRequestProviding {
    
    func getAmeneties(of type: AmenityType,
                      latitude: Double,
                      longitude: Double,
                      radius: Double,
                      completionBlock: @escaping CompletionBlock) {
        
        let amenityResource = AmenityResource(latitude: String(latitude),
                                              longitude: String(longitude),
                                              amenity: type.rawValue,
                                              radius: String(radius))
        
        guard let amenityUrlRequest = createURLRequest(from: amenityResource) else {
            return
        }
        post(request: amenityUrlRequest) { (success, result) in
            if success {
                guard let result = result as? RawOSMData,
                    let elements = result.elements else {
                        completionBlock(false, nil)
                        return
                }
                var jsonElements: [Location] = []
                for element in elements {
                    jsonElements.append(Location(jsonElement: element))
                }
                completionBlock(success, jsonElements as AnyObject)
            }
        }
    }
    
    func get(request: NSMutableURLRequest, completion: @escaping CompletionBlock) { }
    
    func post(request: NSMutableURLRequest, completion: @escaping CompletionBlock) {
        dataTask(request: request, completion: completion)
    }
    
    func put(request: NSMutableURLRequest, completion: @escaping CompletionBlock) { }
    
    func delete(request: NSMutableURLRequest, completion: @escaping CompletionBlock) { }
    
    func createURLRequest<T>(from resource: T) -> NSMutableURLRequest? where T : ApiResourceProviding {
        
        guard let baseUrl = URL(string:self.baseUrl) else {
            return nil
        }
        let locationRequest = NSMutableURLRequest(url:baseUrl,
                                                  cachePolicy: .returnCacheDataElseLoad,
                                                  timeoutInterval: 1.0)
        locationRequest.httpMethod = "POST"
        
        locationRequest.httpBody = resource.data
        resource.headers.forEach { (arg) in
            let (key, value) = arg
            locationRequest.addValue(value, forHTTPHeaderField: key)
        }
        return locationRequest
    }
    
    typealias SerializedType = RawOSMData
    
}

