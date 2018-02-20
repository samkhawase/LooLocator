//
//  LocationProvider.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 14.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//
import CoreLocation

class LocationProvider: NSObject, LocationProvidable, CLLocationManagerDelegate {
    
    fileprivate var locationManager: LocationManagerConfigurable
    fileprivate var currentLocation: CLLocation?
    fileprivate var observer: LocationObservable?
    
    // inject
    init(locationManager:LocationManagerConfigurable){
        self.locationManager = locationManager        
    }
    
    func startLocationUpdates() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.setDelegate(to: self)
            locationManager.setDesiredAccuracy(to: kCLLocationAccuracyBest)
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func getCurrentLocation() -> (Double, Double) {
        guard let currentLocation = currentLocation else {
            return (0,0)
        }
        return (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
    }
    
    // CLLocationManager delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last, let observer = self.observer else {
            return
        }
        currentLocation = lastLocation
        observer.setCurrentLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
    }
}
