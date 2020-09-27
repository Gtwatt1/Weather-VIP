//
//  LocationService.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation

protocol  LocationServiceDelegate: class {
    func didGetLocation(_ lat: String, lng: String)
    func locationdidFail(_ reason: String)
}

class LocationService: NSObject {
    let locationUpdateFailedError = "An error occured while fetching your location, showing default city weather update"
    //Location : Johanessburg
    let defaultLatitude = "-26.2041028"
    let defaultLongitude = "28.0473051"
    weak var delegate: LocationServiceDelegate?
    var locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }

    func startLocationRequest() {
        locationManager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        delegate?.didGetLocation("\(locValue.latitude)", lng: "\(locValue.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationdidFail(locationUpdateFailedError)
        delegate?.didGetLocation(defaultLatitude, lng: defaultLongitude)
    }
}
