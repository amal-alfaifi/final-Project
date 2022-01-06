//
//  LocationRequestController.swift
//  day18
//
//  Created by Amal on 30/05/1443 AH.
//


import UIKit
import CoreLocation

class LocationRequestController: UIViewController {

    //MARK: - Properties
    
    var locationManager: CLLocationManager?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "blue-pin")
        return iv
    }()
    
    let allowLocation: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string:(NSLocalizedString("ALLOW", comment: "")) , attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        
        attributedText.append(NSAttributedString(string:(NSLocalizedString("please enable location service", comment: "")) , attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]))
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedText
        return label
    }()
    let enableLocationButton: UIButton = {
       let button = UIButton()
       button.setTitle((NSLocalizedString("Enable Location", comment: "")), for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       button.backgroundColor = .mainBlue()
       button.layer.cornerRadius = 5
       button.addTarget(self, action: #selector(handleRequestLocation), for: .touchUpInside)
       return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        if locationManager != nil {
            print("g")
        }else {
            print("error")
        }
    }
    
    @objc func handleRequestLocation() {
        guard let locationManager = self.locationManager else {return}
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureViewComponents() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 140, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
        imageView.centerX(inView: view)
        
        view.addSubview(allowLocation)
        allowLocation.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 0)
        allowLocation.centerX(inView: view)
        
        view.addSubview(enableLocationButton)
        enableLocationButton.anchor(top: allowLocation.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
    }
}

extension LocationRequestController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard locationManager?.location != nil else {
           print("Errer setting location..")
           return
            }
        dismiss(animated: true, completion: nil)
    }
}
