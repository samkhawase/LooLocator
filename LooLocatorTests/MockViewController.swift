//
//  MockViewController.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 23.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import Foundation

class MockViewController: MapViewModelObservable {
    func centerMapToCurrentLocation(latitude: Double, longitude: Double) {
        
    }
    
    func setCurrentLocation(latitude: Double, longitude: Double) {}
    func addAmenityToMap(amenity: Location) {}
    typealias Amenity = Location
}
