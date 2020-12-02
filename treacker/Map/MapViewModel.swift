//
//  MapViewModel.swift
//  treacker
//
//  Created by Константин Емельянов on 12.10.2020.
//  Copyright © 2020 Константин Емельянов. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var dots: [CLLocationCoordinate2D] = []
    
    private var locationManager: CLLocationManager
    
    public private(set) var latestLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0) {
        willSet {
            objectWillChange.send()
        }
    }
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations.first! as CLLocation
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            
            if let placemark = placemarks  {
                if placemark.count>0 {
                    let mark = placemark.first
                    self.latestLocation = mark?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                    self.dots.append(self.latestLocation)
                }
            }
        }   
    }
}
