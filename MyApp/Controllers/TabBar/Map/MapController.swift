//
//  LocationVC.swift
//  MyApp
//
//  Created by Amal on 05/05/1443 AH.
//

import UIKit
import MapKit


class MapController: UIViewController {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var searchInputView: SearchInputView!
    var route: MKRoute?
    
    let centerMapButton: UIButton = {
       let button = UIButton ()
        button.setImage(UIImage(named: "اتجاه")!.withRenderingMode(.alwaysOriginal), for: .normal)
       button.addTarget(self, action: #selector(handleCenterLocation), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        enableLocationServices()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        centerMapOnUserLocation(shouldLoadAnnotations: true)
    }
    
    @objc func handleCenterLocation() {
        centerMapOnUserLocation(shouldLoadAnnotations: false)
    }
    
    func configureViewComponents() {
        view.backgroundColor = .white
        configureMapView()
        searchInputView = SearchInputView()
        
        searchInputView.delegate = self
        searchInputView.mapController = self

        view.addSubview(searchInputView)
        searchInputView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -(view.frame.height - 220), paddingRight: 0, width: 0, height: view.frame.height)
        
        view.addSubview(centerMapButton)
        centerMapButton.anchor(top: nil, left: nil, bottom: searchInputView.topAnchor, right: view.rightAnchor, paddingTop: 88, paddingLeft: 0 , paddingBottom: 16, paddingRight: 16, width: 50, height: 50)
        
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        
        view.addSubview(mapView)
        mapView.addConstraintsToFillview(view: view)
    }
}
// MARK: - SearchCellDelegate

extension MapController: SearchCellDelegate {
    func getDirections(forMapItem mapItem: MKMapItem) {
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])

    }
    
    func distanceFromUser(location: CLLocation) -> CLLocationDistance? {
        guard let userLocation = locationManager.location else { return nil }
        return userLocation.distance(from: location)
    }
}
//MARK: - SearchInputViewDelegate

extension MapController: SearchInputViewDelegate {
    
    func selectedAnnotation(withMapItem mapItem: MKMapItem) {
        mapView.annotations.forEach { (annotation) in
            if annotation.title == mapItem.name {
                self.mapView.selectAnnotation(annotation, animated: true)
                self.zoomToFit(selectedAnnotation: annotation)
            }
        }
    }
    func addPolyline(forDestinationMapItem destinationMapItem: MKMapItem) {
        generatePolyline(forDestinationMapItem: destinationMapItem)

    }

    func handleSearch(withSearchText searchText: String) {
        removeAnnotation()
        loadAnnotations(withSearchQuery: searchText)

    }
    
    func animateCenterMapButton(expansionState: SearchInputView.ExpansionState, hideButton: Bool) {
   
        switch expansionState {
        case .NotExpanded:
            UIView.animate (withDuration: 0.25) {
                self.centerMapButton.frame.origin.y -= 250
                
                if hideButton {
                    self.centerMapButton.alpha = 0
                } else {
                    self.centerMapButton.alpha = 1
                }
            }
        case .PartiallyExpanded:
            if hideButton {
               self.centerMapButton.alpha = 0
             } else {
               UIView.animate (withDuration: 0.25) {
                  self.centerMapButton.frame.origin.y += 250
               }
             }
        case .FullyExpanded:
            UIView.animate (withDuration: 0.25) {
                self.centerMapButton.alpha = 1
            }
        }
    }
}

extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let route = self.route {
           let polyline = route.polyline
           let lineRenderer = MKPolylineRenderer(overlay: polyline)
           lineRenderer.strokeColor = .mainBlue()
           lineRenderer.lineWidth = 3
           return lineRenderer
        }
        return MKOverlayRenderer()
    }
}
//MARK: - MapKit helper function

extension MapController {
    
    func zoomToFit(selectedAnnotation: MKAnnotation?) {
       if mapView.annotations.count == 0 {
           return
       }
        var topLeftCoordinate = CLLocationCoordinate2D(latitude: -90, longitude: 180)
        var bottomRightCoordinate = CLLocationCoordinate2D(latitude: 98, longitude: -180)
        
        if let selectedAnnotation = selectedAnnotation {
            for annotation in mapView.annotations {
                if let userAnno = annotation as? MKUserLocation {
                    topLeftCoordinate.longitude = fmin(topLeftCoordinate.longitude, userAnno.coordinate.longitude)
                    topLeftCoordinate.latitude = fmax(topLeftCoordinate.latitude, userAnno.coordinate.latitude)
                    bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, userAnno.coordinate.longitude)
                    bottomRightCoordinate.latitude = fmin(bottomRightCoordinate.latitude, userAnno.coordinate.latitude)
                }
                if annotation.title == selectedAnnotation.title {
                    topLeftCoordinate.longitude = fmin(topLeftCoordinate.longitude, annotation.coordinate.longitude)
                    topLeftCoordinate.latitude = fmax(topLeftCoordinate.latitude, annotation.coordinate.latitude)
                    bottomRightCoordinate.longitude = fmax(bottomRightCoordinate.longitude, annotation.coordinate.longitude)
                    bottomRightCoordinate.latitude = fmin(bottomRightCoordinate.latitude, annotation.coordinate.latitude)
                    
                }
            }
            var region = MKCoordinateRegion(center: CLLocationCoordinate2DMake (topLeftCoordinate.latitude -
            (topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 0.65, topLeftCoordinate.longitude +
                (bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 0.65), span: MKCoordinateSpan(latitudeDelta:
               fabs(topLeftCoordinate.latitude - bottomRightCoordinate.latitude) * 3.0, longitudeDelta:
               fabs(bottomRightCoordinate.longitude - topLeftCoordinate.longitude) * 3.0))
            
            region = mapView.regionThatFits(region)
            mapView.setRegion(region, animated: true)
        }
    }
    func generatePolyline(forDestinationMapItem destinationMapItem: MKMapItem) {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = destinationMapItem
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            
            guard let response = response else { return }
            
            self.route = response.routes[0]
            guard let polyline = self.route?.polyline else { return }
            self.mapView.addOverlay(polyline)
        }
    }
    
    func centerMapOnUserLocation(shouldLoadAnnotations: Bool) {
        guard let coordinates = locationManager.location?.coordinate else {
            return }
        let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        if shouldLoadAnnotations{
           loadAnnotations(withSearchQuery: "Hospital")
        }
    }
    func searchBy(naturalLanguageQuery: String, region: MKCoordinateRegion, coordinates: CLLocationCoordinate2D, completion: @escaping (_
        response: MKLocalSearch.Response?, _ error: NSError?) -> ()) {
        
        let request = MKLocalSearch.Request ()
        request.naturalLanguageQuery = naturalLanguageQuery
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start{ (response, error) in
            
            guard let response = response else {
                  completion (nil, error! as NSError)
                 return
            }
            completion(response, nil)
    }
        }
        
    func removeAnnotation() {
        mapView.annotations.forEach { (annotation) in
           if let annotation = annotation as? MKPointAnnotation {
               mapView.removeAnnotation(annotation)
            }
    }
                    }
        
    func loadAnnotations(withSearchQuery query: String) {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        
        searchBy(naturalLanguageQuery: query, region: region, coordinates: coordinate) { (response, error) in
            
            guard let response = response else { return }
            response.mapItems.forEach({ (mapItem) in
                
                let annotation = MKPointAnnotation()
                annotation.title = mapItem.name
                annotation.coordinate = mapItem.placemark.coordinate
                self.mapView.addAnnotation(annotation)
            })
            self.searchInputView.searchResults = response.mapItems
        }
    }
}


//MARK: - CLLocationManagerDelegate

extension MapController: CLLocationManagerDelegate {
    
    func enableLocationServices() {
    locationManager = CLLocationManager()
    locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            
            DispatchQueue.main.async {
                
                let controller = LocationRequestController()
                controller.locationManager = self.locationManager
              self.present(controller , animated: true , completion: nil)
            }
            
        case .restricted:
            print("Localion auth status is RESTRICTED")
        case .denied:
            print("Location auth status is DENIED")
        case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
        }
        
    }
    
}

