//
//  ApiResourceProviding.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Foundation

protocol ApiResourceProviding {
    var data: Data { get }
    var headers:Dictionary<String, String> { get }
}
