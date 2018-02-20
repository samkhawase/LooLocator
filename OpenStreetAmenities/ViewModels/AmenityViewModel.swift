//
//  AmenityViewModel.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 14.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import CoreLocation

protocol MapViewModelConfirming {
    
    func getCurrentLocation() -> (Double, Double)
    func getAmenities(in range: Int, type: AmenityType)
}

protocol MapViewModelObservable {
    // This needs to be supplied by the VM Observer
    associatedtype Amenity
    
    func setCurrentLocation(latitude: Double, longitude: Double)
    func addAmenityToMap(amenity:Amenity)
}

enum AmenityType: String {
    case Toilets = "toilets"
}

// MapviewModel: Protocol implementation
class MapViewModel: MapViewModelConfirming, LocationObservable {

    var locationProvider: LocationProvidable
    
    // inject the dependencies in ctor
    init(locationProvider: LocationProvidable) {
        self.locationProvider = locationProvider
        self.locationProvider.startLocationUpdates()
    }
    
    func getCurrentLocation() -> (Double, Double) {
        let (lat, lon) = locationProvider.getCurrentLocation()
        return (lat, lon)
    }
    
    func getAmenities(in range: Int, type: AmenityType) {
        //TODO:
    }
    func setCurrentLocation(latitude: Double, longitude: Double) {
        
    }
}
