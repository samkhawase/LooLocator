//
//  ApiResourceProviding.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import Foundation

protocol ApiResourceProviding {
    var data: Data { get }
    var headers:Dictionary<String, String> { get }
}
