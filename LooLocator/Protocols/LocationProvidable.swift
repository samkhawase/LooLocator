//
//  LocationProvidable.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

protocol LocationProvidable {
    var listener: LocationObservable? { get set }
    func setListener(listener: LocationObservable)
    func startLocationUpdates()
    func getCurrentLocation() -> (Double, Double)
}

// to be implemented by the VM
protocol LocationObservable {
    func setCurrentLocation(latitude: Double, longitude: Double)
}
