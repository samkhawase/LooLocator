//
//  Location.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import Contacts
import MapKit

class OSMData: Codable {
    var elements: [Location]?
    
    // MARK: - Codable methods
    enum CodingKeys: String, CodingKey {
        case elements
        case id, lat, lon, tags
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.elements = try container.decode([Location].self, forKey: .elements)
    }
    func encode(to encoder: Encoder) throws {
    }
}

class Location: NSObject, Codable {
    
    // MARK: - variable declarations
    let id: Int
    let title: String?
    let locationDescription: String?
    let coordinates: (Double, Double)
    var amenity: String?
    var fee: Bool?
    var feeAmount: String?
    let isAccessible: Bool
    
    // MARK: - Convenience initializers
    init(id: Int, title:String, locationDescription: String, coordintes: (Double, Double), isAccessible: Bool ) {
        self.id = id
        self.title = title
        self.locationDescription = locationDescription
        self.coordinates = coordintes
        self.isAccessible = isAccessible
    }
        
    // MARK: - Codable methods
    enum CodingKeys: String, CodingKey  {
        case id, lat, lon, tags
        // tags container
        case name, wheelchair, fee, amenity
        case englishName = "name:en"

    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id =  try container.decode(Int.self, forKey: .id)
        
        if let lat = try? container.decode(Double.self, forKey: .lat),
           let lon = try? container.decode(Double.self, forKey: .lon) {
            self.coordinates = (lat, lon)
        } else {
            self.coordinates = (0.0, 0.0)
        }
        
        let tagsContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tags)
        
        self.locationDescription = try? tagsContainer?.decode(String.self, forKey: .name)
        if let _name = try? tagsContainer?.decode(String.self, forKey: .englishName) {
            self.title = _name
        } else {
            self.title = self.locationDescription
        }
        self.isAccessible =  ((try? tagsContainer?.decode(String.self, forKey: .wheelchair)) != nil)
    }
    
    func encode(to encoder: Encoder) throws {
    }
}

// MARK: - MKAnnotation support
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
