//
//  AmenityRequest.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
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
                guard let result = result as? OSMData,
                    let elements = result.elements else {
                        completionBlock(false, nil)
                        return
                }
//                var jsonElements: [Location] = []
//                for element in elements {
//                    jsonElements.append(Location(jsonElement: element))
//                }
                completionBlock(success, elements as AnyObject)
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
                                                  cachePolicy: .reloadIgnoringCacheData,
                                                  timeoutInterval: 1.0)
        locationRequest.httpMethod = "POST"
        
        locationRequest.httpBody = resource.data
        resource.headers.forEach { (arg) in
            let (key, value) = arg
            locationRequest.addValue(value, forHTTPHeaderField: key)
        }
        return locationRequest
    }
    
    typealias SerializedType = OSMData
    
}

