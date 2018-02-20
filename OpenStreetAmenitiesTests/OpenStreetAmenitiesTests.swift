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
                    // Act
                    let (lat, lon) = locationProvider.getCurrentLocation()
                    //Assert
                    expect(lat).to(equal(0))
                    expect(lon).to(equal(0))
                })
            })
        }
        
        fdescribe("MapViewModel tests") {
            var viewModel: MapViewModel<AmenityRequest>?
            beforeEach {
                let mockLocationProvider = MockLocationProvider()
                let mockAmenityRequest = MockAmenityRequest()
                viewModel = MapViewModel(locationProvider: mockLocationProvider, amenityRequest:mockAmenityRequest )
            }
            
            it("get current location", closure: {
                if let (lat, lon) = viewModel?.getCurrentLocation() {
                    expect(lat).to(equal(52.51631))
                    expect(lon).to(equal(13.37777))
                }
            })
            it("should get all amenities in range", closure: {
                var successFlag = false
                var locations: [Location] = []
                viewModel?.getAmenities(in: 1000, type: AmenityType.Toilets, completion: {
                    (success, results) in
                    successFlag = success
                    if successFlag, let results = results as? [Location] {
                        locations = results
                    }
                })
                //Assert
                expect(successFlag).toEventuallyNot(beFalse())
                expect(locations).toEventuallyNot(beEmpty())
                
                expect(locations.first?.id).toEventuallyNot(beEmpty())
                expect(locations.first?.coordinates.0).toEventuallyNot(equal(0))
                expect(locations.first?.coordinates.1).toEventuallyNot(equal(0))
            })
        }
        
        describe("Amenity Request tests") {
            let amenityReqeust = AmenityRequest()
            it("should fetch amenities", closure: {
                // Arrange
                var successFlag = false
                var locations: [Location] = []
                // Act
                amenityReqeust.getAmeneties(of: AmenityType.Toilets,
                                            latitude: 52.51631,
                                            longitude: 13.37777,
                                            radius: 1000,
                                            completionBlock: { (success, results) in
                                                successFlag = success
                                                if successFlag, let results = results as? [Location] {
                                                    locations = results
                                                }
                })

                //Assert
                expect(successFlag).toEventuallyNot(beFalse())
                expect(locations).toEventuallyNot(beEmpty())
                
                expect(locations.first?.id).toEventuallyNot(beEmpty())
                expect(locations.first?.coordinates.0).toEventuallyNot(equal(0))
                expect(locations.first?.coordinates.1).toEventuallyNot(equal(0))
            })
        }
    }
}




















