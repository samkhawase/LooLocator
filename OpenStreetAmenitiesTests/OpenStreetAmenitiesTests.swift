//
//  OpenStreetAmenitiesTests.swift
//  OpenStreetAmenitiesTests
//
//  Created by Sam Khawase on 14.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import XCTest
import Quick
import Nimble
import CoreLocation

@testable import OpenStreetAmenities

class OpenStreetAmenitiesTests: QuickSpec {
    override func spec() {
        describe("LocationProvider protocol") {
            context("When started with LocationManager", closure: {
                // Arrange
                let mockLocationManager = MockLocationManager()
                let locationProvider: LocationProvidable = LocationProvider(locationManager: mockLocationManager)
                beforeEach {
                    mockLocationManager.callCount = 0
                }
                it("starts location updates", closure: {
                    // Act
                    locationProvider.startLocationUpdates()
                    //Assert
                    expect(mockLocationManager.callCount).to(equal(4))
                })
                it("provides current location", closure: {
                    let (lat, lon) = locationProvider.getCurrentLocation()
                    expect(lat).to(equal(0))
                    expect(lon).to(equal(0))
                })
            })
        }
    }
}
