//
//  CLLocationManagerExtension.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import CoreLocation

// CoreLocation extenstion for protocol conformance
extension CLLocationManager: LocationManagerConfigurable {
    func setDelegate(to instance: AnyObject) {
        guard let delegate = instance as? CLLocationManagerDelegate else {
            return
        }
        self.delegate = delegate
    }
    func setDesiredAccuracy(to accuracy: Double) {
        let accuracy = accuracy as CLLocationAccuracy
        self.desiredAccuracy = accuracy
    }
}
