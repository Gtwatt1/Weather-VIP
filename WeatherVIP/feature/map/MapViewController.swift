//
//  MapViewController.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 28/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var favoriteCities: [FavoriteCity]?
    var mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addMapView()
        showCityOnMap()
        title = "Favorite Cities"
    }

    func addMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }

    func showCityOnMap() {
        var annotations = [MKPointAnnotation]()
        favoriteCities?.forEach({ (city) in
            if let location = city.location {
                let annotation = MKPointAnnotation()
                annotation.title = city.cityName
                annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                                longitude: location.longitude)
                annotations.append(annotation)
            }
        })
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
}
