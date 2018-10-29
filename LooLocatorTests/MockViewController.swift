//
//  MockViewController.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 23.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

import Foundation

class MockViewController: MapViewModelObservable {
    func centerMapToCurrentLocation(latitude: Double, longitude: Double) {
        
    }
    
    func setCurrentLocation(latitude: Double, longitude: Double) {}
    func addAmenityToMap(amenity: Location) {}
    typealias Amenity = Location
}
