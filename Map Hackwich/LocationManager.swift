//
//  LocationManager.swift
//  Map Hackwich
//
//  Created by Tom Bredemeier on 2/2/26.
//

import Foundation
import CoreLocation
//import MapKit

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    override init() {
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
}


