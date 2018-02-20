//
//  LocationMocks.swift
//  OpenStreetAmenitiesTests
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

@testable import OpenStreetAmenities

class MockLocationProvider: LocationProvidable {
    internal var callCount = 0
    func startLocationUpdates() {
        callCount += 1
    }
    
    func getCurrentLocation() -> (Double, Double) {
        callCount += 1
        return (52.51631, 13.37777)
    }
}

class MockLocationManager: LocationManagerConfigurable {
    internal var callCount = 0
    func setDelegate(to instance: AnyObject) {
        callCount += 1
    }
    
    func setDesiredAccuracy(to accuracy: Double) {
        callCount += 1
    }
    
    func requestAlwaysAuthorization() {
        callCount += 1
    }
    func startUpdatingLocation() {
        callCount += 1
    }
}
