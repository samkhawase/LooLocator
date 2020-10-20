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
                               completionBlock: @escaping (Result<AmenityRequest.SerializedType, Error>) -> Void) {
        let jsonDecoder = JSONDecoder()
        if let jsonData = """
            {
                "elements": [
                             {
                                 "type": "node",
                                 "id": 66917214,
                                 "lat": 52.5168607,
                                 "lon": 13.3829509,
                                 "tags": {
                                     "amenity": "toilets",
                                     "fee": "yes",
                                     "name": "City Toilette",
                                     "toilets:wheelchair": "yes",
                                     "wheelchair": "yes"
                                }
                            }
                    ]
            }
            """.data(using: .utf8),
           let dummyOSMData = try? jsonDecoder.decode(OSMData.self, from: jsonData) {
            completionBlock(.success(dummyOSMData))
        }
    }
}
