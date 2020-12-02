//
//  MapView.swift
//  treacker
//
//  Created by Константин Емельянов on 08.10.2020.
//  Copyright © 2020 Константин Емельянов. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    
    @ObservedObject var vm  = MapViewModel()
    let view = MapViewController()
    
    func makeUIView(context: Context) -> MKMapView {
        view.mapView.showsUserLocation = true
        view.points = self.vm.dots   
        print(self.vm.dots)
        view.viewDidLoad()
        return view.mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        self.view.update()
    }
}


final class MapViewController: UIViewController{
    
    var mapView = MKMapView()
    var points: [CLLocationCoordinate2D] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupManager()
        self.mapView.delegate = self
        setupMapView()
        print(points)
//        let circle = MKCircle(center: points.first, radius: 1000)
//        self.mapView.addOverlay(circle)
        let polyline = MKPolyline(coordinates: points, count: points.count)
        self.mapView.addOverlay(polyline)
        }
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func setupMapView() {
        mapView.userTrackingMode = .followWithHeading
        mapView.showsCompass = true
        mapView.showsScale = true
    }
    
    func update() {
        let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D (latitude: 0, longitude: 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        print(self.points)
        drawLine()
    }
    
    func drawLine() {
        let line = MKPolyline(coordinates: self.points, count: self.points.count)
        self.mapView.addOverlay(line)
    }
}

extension MapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->  MKOverlayRenderer {
//        
//        let renderer = MKCircleRenderer(overlay: overlay)
//        renderer.fillColor = UIColor.blue.withAlphaComponent(0.3)
//        renderer.strokeColor = .blue
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.fillColor = UIColor.orange
        renderer.lineWidth = 3
        
        print(1)
        return renderer
    }
    
}
