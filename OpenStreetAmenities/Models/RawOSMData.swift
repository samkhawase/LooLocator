//
//  RawOSMDTO.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Foundation
internal struct RawOSMData: Codable {
    var version: Double
    var generator: String
    var elements: [OSMElement]?
    var osm3s: OSM3S?
    
    struct OSM3S: Codable {
        var timestamp_osm_base: String
        var copyright: String
    }
}

internal struct OSMElement: Codable {
    var type: String?
    var id: Int?
    var lat: Double?
    var lon: Double?
    var tags: Tags?
    struct Tags: Codable {
        var amenity: String?
        var fee: String?
        var name: String?
        var englishName: String?
        var wheelchair: String?
        enum CodingKeys: String, CodingKey {
            case englishName = "name:en"
            case amenity = "amenity"
            case fee = "fee"
            case name = "name"
            case wheelchair = "wheelchair"
        }
    }
}
