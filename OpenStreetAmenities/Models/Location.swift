//
//  Location.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Foundation

struct Location {
    
    let id: String
    let title: String?
    let locationName: String
    let coordinates: (Double, Double)
    
    var amenity: String?
    var fee: Bool?
    var feeAmount: String?
    let accessibility: WheelChairAccessibility
    
    init(id: String, title:String, locationName: String, coordintes: (Double, Double), isAccessible: Bool ) {
        self.id = id
        self.title = title
        self.locationName = locationName
        self.coordinates = coordintes
        self.accessibility = WheelChairAccessibility(isAccessible: isAccessible)
    }
    init(jsonElement: OSMElement) {
        self.init(id: String(describing: jsonElement.id),
                  title: jsonElement.tags?.name ?? "",
                  locationName: jsonElement.tags?.name ?? "",
                  coordintes: (jsonElement.lat ?? 0.0, jsonElement.lon ?? 0.0),
                  isAccessible: jsonElement.tags?.wheelchair != nil)
    }
}

struct WheelChairAccessibility {
    var isAccessible: Bool
    var description: String?
    
    init(isAccessible: Bool) {
        self.isAccessible = isAccessible
    }
}

/* Sample data from OSM
 {
 "type": "node",
 "id": 71180687,
 "lat": 52.5175448,
 "lon": 13.3738695,
 "tags": {
 "amenity": "toilets",
 "fee": "yes",
 "toilets:wheelchair": "yes",
 "wheelchair": "yes",
 "wheelchair:description": "Euro-Schlüssel notwendig"
 }
 }
 */
