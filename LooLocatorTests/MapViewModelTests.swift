//
//  MapViewModelTests.swift
//  LooLocatorTests
//
//  Created by Sam Khawase on 23.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import XCTest
import Quick
import Nimble
import CoreLocation
import OHHTTPStubs

class MapViewModelTests: QuickSpec {
    override func spec() {
        describe("Given a MapViewModel") {
            var viewModel: MapViewModel<MockViewController>?
            beforeEach {
                let mockLocationProvider = MockLocationProvider()
                let mockAmenityRequest = MockAmenityRequest()
                let mockViewController = MockViewController()
                viewModel = MapViewModel(locationProvider: mockLocationProvider,
                                         amenityRequest:mockAmenityRequest,
                                         listener:mockViewController)
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
                
                expect(locations.first?.id).toEventuallyNot(equal(0))
                expect(locations.first?.title).toEventually(equal("Dummy Amenity"))
                
                expect(locations.first?.coordinates.0).toEventuallyNot(equal(0))
                expect(locations.first?.coordinates.1).toEventuallyNot(equal(0))
            })
        }
    }
}
