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
                viewModel?.getAmenities(in: 1000, type: AmenityType.Toilets) { result in
                    switch result {
                    case .success(let _locations):
                        locations = _locations
                        successFlag = true
                    case .failure(_):
                        successFlag = false
                    }
                }
                //Assert
                expect(successFlag).toEventuallyNot(beFalse())
                expect(locations).toEventuallyNot(beEmpty())
                
                expect(locations.first?.id).toEventually(equal(66917214))
                expect(locations.first?.title).toEventually(equal("City Toilette"))
                
                expect(locations.first?.coordinates.0).toEventually(equal(52.5168607))
                expect(locations.first?.coordinates.1).toEventually(equal(13.3829509))
            })
        }
    }
}
