//
//  LocationManagerConfigurable.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import CoreLocation

protocol LocationManagerConfigurable {
    // wrap var delegate and desiredAccuracy to keep it platform agnostic
    func setDelegate(to instance: CLLocationManagerDelegate?)
    func setDesiredAccuracy(to accuracy: CLLocationAccuracy)
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
}
