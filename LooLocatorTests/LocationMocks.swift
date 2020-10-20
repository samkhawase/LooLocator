//
//  LocationMocks.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import MapKit

class MockLocationProvider: LocationProvidable {
    var listener: LocationObservable?
    
    func setListener(listener: LocationObservable) {
        self.listener = listener
    }

    func startLocationUpdates() {
        listener?.setCurrentLocation(latitude: 52.51631, longitude: 13.37777)
    }
    
    func getCurrentLocation() -> (Double, Double) {
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
    
    func setDelegate(to instance: CLLocationManagerDelegate?) {
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
