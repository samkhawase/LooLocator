//
//  LocationMocks.swift
//  OpenStreetAmenitiesTests
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import MapKit
@testable import OpenStreetAmenities

class MockLocationProvider: LocationProvidable {
    var listener: LocationObservable?
    
    func setListener(listener: LocationObservable) {
        self.listener = listener
    }
    
    internal var callCount = 0
    func startLocationUpdates() {
        callCount += 1
        listener?.setCurrentLocation(latitude: 52.51631, longitude: 13.37777)
    }
    
    func getCurrentLocation() -> (Double, Double) {
        callCount += 1
        return (52.51631, 13.37777)
    }
}
class MockLocationObservable: LocationObservable {
    internal var coordinates: (Double, Double)?
    func setCurrentLocation(latitude: Double, longitude: Double) {
        coordinates = (latitude, longitude)
    }
}

class MockLocationManager: LocationManagerConfigurable {
    internal var callCount = 0
    fileprivate var delegate: LocationProvider?
    
    func setDelegate(to instance: AnyObject) {
        callCount += 1
        delegate = instance as? LocationProvider
    }
    
    func setDesiredAccuracy(to accuracy: Double) {
        callCount += 1
    }
    
    func requestAlwaysAuthorization() {
        callCount += 1
    }
    func startUpdatingLocation() {
        callCount += 1
        updateLocation()
    }
    func updateLocation() {
        let mockLocation = CLLocation(latitude: CLLocationDegrees(52.51631), longitude: CLLocationDegrees(13.37777))
        let mockLocationManager = CLLocationManager()
        delegate?.locationManager(mockLocationManager, didUpdateLocations: [mockLocation])
    }
}
