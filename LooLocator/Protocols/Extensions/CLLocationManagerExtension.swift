//
//  CLLocationManagerExtension.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
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
