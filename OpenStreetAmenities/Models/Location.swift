//
//  Location.swift
//  OpenStreetAmenities
//
//  Created by Sam Khawase on 15.02.18.
//  Copyright © 2018 OpenStreetAmenities. All rights reserved.
//

import Contacts
import MapKit

class Location: NSObject {
    let id: String
    let title: String?
    let locationDescription: String
    let coordinates: (Double, Double)
    var amenity: String?
    var fee: Bool?
    var feeAmount: String?
    let isAccessible: Bool
    
    init(id: String, title:String, locationDescription: String, coordintes: (Double, Double), isAccessible: Bool ) {
        self.id = id
        self.title = title
        self.locationDescription = locationDescription
        self.coordinates = coordintes
        self.isAccessible = isAccessible
    }
    convenience init(jsonElement: OSMElement) {
        self.init(id: String(describing: jsonElement.id),
                  title: jsonElement.tags?.englishName ?? jsonElement.tags?.name ?? "Unknown Amenity",
                  locationDescription: jsonElement.tags?.name ?? "Toilet",
                  coordintes: (jsonElement.lat ?? 0.0, jsonElement.lon ?? 0.0),
                  isAccessible: jsonElement.tags?.wheelchair != nil)
    }
}

extension Location: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinates.0), longitude: CLLocationDegrees(coordinates.1))
    }
    var subtitle: String? {
        return "\(isAccessible ? "♿︎" : "")"
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
