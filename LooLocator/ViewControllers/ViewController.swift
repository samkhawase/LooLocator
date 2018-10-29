//
//  ViewController.swift
//  LooLocator
//
//  Created by Sam Khawase on 14.02.18.
//  Copyright © 2018 LooLocator. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private(set) lazy var viewModel: MapViewModel<ViewController> = {
        let _viewModel = MapViewModel(locationProvider: amenityLocationProvider, amenityRequest: amenityRequest, listener: self)
        return _viewModel
    }()
    private(set) lazy var amenityLocationProvider: LocationProvidable = {
        let _locationProvider = LocationProvider(locationManager: locationManager)
        return _locationProvider
    }()
    
    private(set) lazy var amenityRequest: AmenityRequest = {
        let _amenityRequest = AmenityRequest()
        return _amenityRequest
    }()
    
    private(set) lazy var locationManager: LocationManagerConfigurable = {
        let _clLocationManager = CLLocationManager()
        return _clLocationManager
    }()

    let regionRadius: CLLocationDistance = 500
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = viewModel.getCurrentLocation()
    }
    
    fileprivate func getAmenities() {
        viewModel.getAmenities(in: 1000, type: .Toilets) { (success, locations) in
            guard let locations = locations as? [Location] else {
                return
            }
            for location in locations {
                print("Location.coordinate: \(location.coordinate.latitude) : \(location.coordinate.longitude)")
                DispatchQueue.main.async { [weak self] in
                    self?.mapView.addAnnotation(location)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    @IBAction func resetLocation(_ sender: Any) {
        viewModel.centerMapToCurrentLocationAction()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius,
                                                                  longitudinalMeters: regionRadius)
        DispatchQueue.main.async { [weak self] in
            self?.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
}

extension ViewController: MapViewModelObservable{
    typealias Amenity = Location
    func addAmenityToMap(amenity: Location) { }
    func setCurrentLocation(latitude: Double, longitude: Double) {
        print("current latitude: \(latitude), longitude: \(longitude)")
        let currentLocation = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        centerMapOnLocation(location: currentLocation)
        getAmenities()
    }
    func centerMapToCurrentLocation(latitude: Double, longitude: Double) {
        let currentLocation = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        centerMapOnLocation(location: currentLocation)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Location else {
            return nil
        }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? Location else {
            return
        }
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}


