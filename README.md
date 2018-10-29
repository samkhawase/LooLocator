
# LooLocator

Find Amenities (*like toilets*) near you! The simple iOS  fetches the crowd-sourced data from OpenStreetMap, and shows toilets within walking distance. 
User can then use AppleMaps to find walking directions to the amenity. 

## Design Rationale

The following series of bite-sized posts explain the design rationale behind creating the app:

1. [Part 1: Introduction - Writing a modular, and testable iOS App in Swift using MVVM pattern](https://samkhawase.com/blog/mvvm_swift_introduction/)
2. [Part 2: Defining the Data Model](https://samkhawase.com/blog/mvvm_swift_model/)
3. [Part 3: The Location provider](https://samkhawase.com/blog/mvvm_swift_location_provider/)
4. [Part 4: Defining the networking layer](https://samkhawase.com/blog/mvvm_swift_networking/)
5. [Part 5: The ViewModel](https://samkhawase.com/blog/mvvm_swift_view_model/)
6. [Part 6: The Final App - Putting it all together](https://samkhawase.com/blog/mvvm_swift_final_app/)



## Getting Started

Here are the steps to get started with the project on your local machine:
1. Clone the git repositiory
2. Run `carthage update --platform iOS --cache-builds --no-use-binaries` to fetch the dependencies.
3. If running on the simulator, you can edit the scheme and set the simulated location in Xcode. (*E.g. Hongkong*)
4. Run the project via Xcode.

### Prerequisites

What things you need to install the software and how to install them

1. Mac OS X
2. Xcode 9
3. [Carthage](https://github.com/Carthage/Carthage) 
4. Optional: [xcpretty](https://github.com/supermarin/xcpretty)

## Running the tests

The app uses BDD style tests using Quick and Nimble. There are unit tests written to test the LocationManager, APIClient (*with Network mocks*), and ViewModel behaviors. 
To run the test, enter the command on the command line.

```
xcodebuild -scheme 'LooLocator' \
			-sdk iphonesimulator \
			-configuration Debug \
			-destination 'platform=iOS Simulator,name=iPhone 6s,OS=latest' \
			test | xcpretty
```

The output will be similar to 

```
Test Suite LooLocatorTests.xctest started
ApiClientTests
    ✓ Amenity_Request_tests__should_fetch_amenities (0.027 seconds)
LocationProviderTests
    ✓ Given_a_LocationProvider__When_it_s_started_with_LocationManager__then_starts_location_updates (1.547 seconds)
    ✓ Given_a_LocationProvider__When_it_s_started_with_LocationManager__then_provides_current_location (0.001 seconds)
MapViewModelTests
    ✓ Given_a_MapViewModel__get_current_location (0.002 seconds)
    ✓ Given_a_MapViewModel__should_get_all_amenities_in_range (0.004 seconds)
``` 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This project is inspired by the MapKit article from [RayWenderlich](https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started)
* The [Overpass Turbo API](https://overpass-turbo.eu/)

