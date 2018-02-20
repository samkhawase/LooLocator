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
    func getAmenities(in range: Int, type: AmenityType, completion: @escaping CompletionBlock)
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
class MapViewModel<T: AmenityRequest>: MapViewModelConfirming, LocationObservable {

    var locationProvider: LocationProvidable
    var amenityRequest: T
    
    // inject the dependencies in ctor
    init(locationProvider: LocationProvidable, amenityRequest: T) {
        self.locationProvider = locationProvider
        self.locationProvider.startLocationUpdates()
        self.amenityRequest = amenityRequest
    }
    
    func getCurrentLocation() -> (Double, Double) {
        let (lat, lon) = locationProvider.getCurrentLocation()
        return (lat, lon)
    }
    
    func getAmenities(in range: Int, type: AmenityType, completion: @escaping CompletionBlock) {
        let (lat, lon) = getCurrentLocation()
        amenityRequest.getAmeneties(of: AmenityType.Toilets,
                                    latitude: lat,
                                    longitude: lon,
                                    radius: Double(range)) { (success, locations) in
                                        completion(success, locations)
        }
    }
    
    // This is a message from the location provider
    func setCurrentLocation(latitude: Double, longitude: Double) {
        
    }
}
