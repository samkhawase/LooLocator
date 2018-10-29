//
//  RawOSMDTO.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

import Foundation

internal struct RawOSMData: Codable {
    // We're interested only in elements, and can ignore other elements
    var elements: [OSMElement]?
    private enum CodingKeys: String, CodingKey {
        case elements
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
