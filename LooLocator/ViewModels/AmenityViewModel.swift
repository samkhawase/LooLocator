//
//  AmenityViewModel.swift
//  LooLocator
//
//  Created by Sam Khawase on 14.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import CoreLocation

protocol MapViewModelConfirming {
    func getCurrentLocation() -> (Double, Double)
    func getAmenities(in range: Int, type: AmenityType, completion: @escaping CompletionBlock)
    func centerMapToCurrentLocationAction()
}

protocol MapViewModelObservable {
    // This needs to be supplied by the VM Observer
    associatedtype Amenity
    
    func setCurrentLocation(latitude: Double, longitude: Double)
    func addAmenityToMap(amenity:Amenity)
    func centerMapToCurrentLocation(latitude: Double, longitude: Double)
}

enum AmenityType: String {
    case Toilets = "toilets"
}

// MapviewModel: Protocol implementation
class MapViewModel<S:MapViewModelObservable>: MapViewModelConfirming, LocationObservable {

    var locationProvider: LocationProvidable
    var amenityRequest: AmenityRequest
    var listenerView: S
    
    // inject the dependencies in ctor
    init(locationProvider: LocationProvidable, amenityRequest: AmenityRequest, listener: S) {
        self.locationProvider = locationProvider
        self.locationProvider.startLocationUpdates()
        self.amenityRequest = amenityRequest
        self.listenerView = listener
        
        defer {
            self.locationProvider.setListener(listener: self)
        }
    }
    
    func getCurrentLocation() -> (Double, Double) {
        let (lat, lon) = locationProvider.getCurrentLocation()
        return (lat, lon)
    }
    
    func getAmenities(in range: Int, type: AmenityType, completion: @escaping CompletionBlock) {
        let (lat, lon) = getCurrentLocation()
        print("latitude: \(lat) longitude: \(lon)")
        if lat == 0 && lon == 0 {
            completion(false, nil)
        }
        amenityRequest.getAmeneties(of: AmenityType.Toilets,
                                    latitude: lat,
                                    longitude: lon,
                                    radius: Double(range)) { (success, locations) in
                                        completion(success, locations)
        }
    }
    
    // This is a message from the location provider
    func setCurrentLocation(latitude: Double, longitude: Double) {
        listenerView.setCurrentLocation(latitude: latitude, longitude: longitude)
    }
    func centerMapToCurrentLocationAction() {
        let currentLocation = getCurrentLocation()
        listenerView.centerMapToCurrentLocation(latitude: currentLocation.0, longitude: currentLocation.1)
    }
}
