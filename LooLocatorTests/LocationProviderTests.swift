//
//  LooLocatorTests.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 14.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import XCTest
import Quick
import Nimble

class LocationProviderTests: QuickSpec {
    override func spec() {
        describe("Given a LocationProvider") {
            context("When it's started with LocationManager", closure: {
                // Arrange
                let mockLocationManager = MockLocationManager()
                let mockLocationObservable = MockLocationObservable()
                let locationProvider: LocationProvidable = LocationProvider(locationManager: mockLocationManager)
                beforeEach {
                    mockLocationManager.callCount = 0
                }
                it("then starts location updates", closure: {
                    locationProvider.setListener(listener: mockLocationObservable)
                    // Act
                    locationProvider.startLocationUpdates()
                    //Assert
                    expect(mockLocationManager.callCount).toEventually(equal(4))
                    expect(mockLocationObservable.coordinates).toEventuallyNot(beNil())
                    expect(mockLocationObservable.coordinates?.0).toEventually(equal(52.51631))
                    expect(mockLocationObservable.coordinates?.1).toEventually(equal(13.37777))
                })
                
                it("then provides current location", closure: {
                    // Act
                    let (lat, lon) = locationProvider.getCurrentLocation()
                    //Assert
                    expect(lat).to(equal(52.51631))
                    expect(lon).to(equal(13.37777))
                })
            })
        }
    }
}
