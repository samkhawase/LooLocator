//
//  Location.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Contacts
import MapKit

class Location: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    let id: String
    let title: String?
    
    var subtitle: String? {
        return "\(accessibility.isAccessible ? "♿︎" : "")"
    }
    
    let locationDescription: String
    let coordinates: (Double, Double)
    
    var amenity: String?
    var fee: Bool?
    var feeAmount: String?
    let accessibility: WheelChairAccessibility
    
    init(id: String, title:String, locationDescription: String, coordintes: (Double, Double), isAccessible: Bool ) {
        self.id = id
        self.title = title
        self.locationDescription = locationDescription
        self.coordinates = coordintes
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinates.0), longitude: CLLocationDegrees(coordinates.1))
        self.accessibility = WheelChairAccessibility(isAccessible: isAccessible)
    }
    convenience init(jsonElement: OSMElement) {
        self.init(id: String(describing: jsonElement.id),
                  title: jsonElement.tags?.englishName ?? jsonElement.tags?.name ?? "Unknown Amenity",
                  locationDescription: jsonElement.tags?.name ?? "Toilet",
                  coordintes: (jsonElement.lat ?? 0.0, jsonElement.lon ?? 0.0),
                  isAccessible: jsonElement.tags?.wheelchair != nil)
    }
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: title!]
        let mapCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinates.0), longitude: CLLocationDegrees(coordinates.1))
        let placemark = MKPlacemark(coordinate: mapCoordinates, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}

struct WheelChairAccessibility {
    var isAccessible: Bool
    var description: String?
    
    init(isAccessible: Bool) {
        self.isAccessible = isAccessible
    }
}

/* Sample data from OSM
 {
 "type": "node",
 "id": 71180687,
 "lat": 52.5175448,
 "lon": 13.3738695,
 "tags": {
 "amenity": "toilets",
 "fee": "yes",
 "toilets:wheelchair": "yes",
 "wheelchair": "yes",
 "wheelchair:description": "Euro-Schlüssel notwendig"
 }
 }
 */
