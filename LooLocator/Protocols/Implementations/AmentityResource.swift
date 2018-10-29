//
//  AmentityResource.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

import Foundation

class AmenityResource: ApiResourceProviding {
    
    var latitude: String
    var longitude: String
    var amenityType: String
    var radius: String
    
    init(latitude: String, longitude: String, amenity: String, radius: String) {
        self.longitude = longitude
        self.latitude = latitude
        self.amenityType = amenity
        self.radius = radius
    }
    
    // OSM Needs the data in XML format
    var data: Data {
        if let _data = """
            <osm-script output="json">
            <query into="_" type="node">
            <has-kv k="amenity" modv="" v="\(amenityType)"/>
            <around from="_" into="_" lat="\(latitude)" lon="\(longitude)" radius="\(radius)"/>
            </query>
            <print e="" from="_" geometry="skeleton" limit="" mode="body" n="" order="id" s="" w=""/>
            </osm-script>
            """.data(using: String.Encoding.utf8) {
            return _data
        } else {
            return Data()
        }
    }
    
    var headers: Dictionary<String, String> {
        var _headers = Dictionary<String, String>()
        
        _headers["Content-Type"] = "application/xml"
        _headers["Access-Control-Allow-Origin"] = "*"
        _headers["Access-Control-Allow-Origin"] = "*/*"
        
        return _headers
    }
    
}
