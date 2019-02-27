//
//  LocationManager.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override init(){
        super.init()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else {return}
        self.coordinate = coordinate
    }
}
