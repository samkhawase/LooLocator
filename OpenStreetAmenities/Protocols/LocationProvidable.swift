//
//  LocationProvidable.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

protocol LocationProvidable {
    func startLocationUpdates()
    func getCurrentLocation() -> (Double, Double)
}

// to be implemented by the VM
protocol LocationObservable {
    func setCurrentLocation(latitude: Double, longitude: Double)
}
