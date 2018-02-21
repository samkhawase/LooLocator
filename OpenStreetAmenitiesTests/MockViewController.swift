//
//  MockViewController.swift
//  OpenStreetAmenitiesTests
//
//  Created by Sam Khawase on 23.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Foundation
@testable import OpenStreetAmenities

class MockViewController: MapViewModelObservable {
    func setCurrentLocation(latitude: Double, longitude: Double) {}
    func addAmenityToMap(amenity: Location) {}
    typealias Amenity = Location
}
