//
//  LocationVC.swift
//  MyApp
//
//  Created by Amal on 05/05/1443 AH.
//

import UIKit
import MapKit
class MapVC: UIViewController {

        let mapView : MKMapView = {
            let map = MKMapView()
            map.overrideUserInterfaceStyle = .light
            map.translatesAutoresizingMaskIntoConstraints = false
            return map
        }()
    func configureMap() {
         let center = CLLocationCoordinate2D(latitude: 18.222302509549063, longitude: 42.51460111562375)
         let span = MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
         let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        self.annotationLocations
       }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
         view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        configureMap()
        
        createAnnotations(locations: annotationLocations)
    }
    
    let annotationLocations = [
        ["title": "King faisal medical city", "latitude": 18.19648, "longitude": 42.70139],
        ["title": "Aseer central hospital", "latitude": 18.19925, "longitude":42.52484],
        ["title": "Uhud Rafidah General Hospital", "latitude": 18.17310, "longitude":42.84903],
        ["title": "Mustasharak Hospital", "latitude": 18.28490, "longitude":42.73103],
        ["title": "German Hospital", "latitude": 18.2813590, "longitude":42.66912],
        ["title": "Saudi Specialist Medical Center", "latitude": 18.28130, "longitude":42.66913],
        ["title": "Khamis Mushait General Hospital", "latitude": 18.27476, "longitude":42.73476]
         ]

    func createAnnotations(locations: [[String : Any]]) {
        for location in locations {
             let annotations = MKPointAnnotation()
             annotations.title = location["title"] as? String
             annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees,
            longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
        }
        
    }
         }
