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
    func setDelegate(to instance: CLLocationManagerDelegate?) {
        guard let delegate = instance else {
            return
        }
        self.delegate = delegate
    }
	// Changed this because CLLocationAccuracy is just a typealias for Double
    func setDesiredAccuracy(to accuracy: CLLocationAccuracy) {
        self.desiredAccuracy = accuracy
    }
}
