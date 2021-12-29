//
//  LocationVC.swift
//  MyApp
//
//  Created by Amal on 05/05/1443 AH.
//

import UIKit
import MapKit

let locationManger = CLLocationManager()
class MapVC: UIViewController , UISearchBarDelegate {

    let myMapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 350,height: 15))
    
     func searchBar(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //ActivityIndicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        self.view.addSubview(activityIndicator)
        
        // Hide Search
        searchBar.resignFirstResponder()
        
        //Search Request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch =  MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil
            {
                print("ERROR: Try Again")
            }
            else {
                //Removing Annotations
                let annotations = self.myMapView.annotations
                self.myMapView.removeAnnotations(annotations)
                
                //Getting Data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                //Zoom In
                let  coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.myMapView.setRegion(region, animated: true)
                
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myMapView)
       NSLayoutConstraint.activate([
        myMapView.topAnchor.constraint(equalTo: self.view.topAnchor),
        myMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        myMapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        myMapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
       ])
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = NSLocalizedString("Search", comment: "")
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        createAnnotations(locations: annotationLocations)
        locationManger.requestWhenInUseAuthorization()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.distanceFilter = kCLDistanceFilterNone
        locationManger.startUpdatingLocation()
        myMapView.showsUserLocation = true
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
            myMapView.addAnnotation(annotations)
        }
        
    }
    
}

