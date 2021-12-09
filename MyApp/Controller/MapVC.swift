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
        return map
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapConstraints()
    }
    func setMapConstraints() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let Aseer = MKPointAnnotation()
        Aseer.title = "Aseer central hospital"
        Aseer.coordinate = CLLocationCoordinate2D(latitude: 18.19953, longitude: 42.52503)
        mapView.addAnnotation(Aseer)

        let medicalCity = MKPointAnnotation()
        medicalCity.title = "King faisal medical city"
        medicalCity.coordinate = CLLocationCoordinate2D(latitude: 24.7135517, longitude: 46.6752957)
        mapView.addAnnotation(medicalCity)
        
        let generalHospital = MKPointAnnotation()
        generalHospital.title = "Uhud Rafidah General Hospital"
        generalHospital.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        mapView.addAnnotation(generalHospital)
        
        let mustasharak = MKPointAnnotation()
        mustasharak.title = "Mustasharak Hospital"
        mustasharak.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        mapView.addAnnotation(mustasharak)
        
        let german = MKPointAnnotation()
        german.title = "German Hospital"
        german.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        mapView.addAnnotation(german)
        
        let medicalCenter = MKPointAnnotation()
        medicalCenter.title = "Saudi Specialist Medical Center"
        medicalCenter.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        mapView.addAnnotation(medicalCenter)
        
        let gH = MKPointAnnotation()
        gH.title = "Khamis Mushait General Hospital"
        gH.coordinate = CLLocationCoordinate2D(latitude: 18.084764, longitude: 43.138569)
        mapView.addAnnotation(gH)
    }
}
