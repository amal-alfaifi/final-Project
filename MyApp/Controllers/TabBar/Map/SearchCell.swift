//
//  SearchCell.swift
//  MyApp
//
//  Created by Amal on 30/05/1443 AH.
//

import MapKit
import UIKit

protocol SearchCellDelegate {
   func distanceFromUser(location: CLLocation) -> CLLocationDistance?
    func getDirections(forMapItem mapItem: MKMapItem)
}
class SearchCell: UITableViewCell {
    
    //MARK: - Properites
    
    var delegate: SearchCellDelegate?

    //  MKMapItemنقطة اهتمام على الخريطة.
    var mapItem: MKMapItem? {
       didSet {
           configureCell()
       }}
    
    lazy var imageContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(locationImageView)
        locationImageView.center(inView: view)
        locationImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
       return view
    }()
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .mainPink()
        iv.image = UIImage(named: "ابيض")
        return iv
    }()
    
    let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont (ofSize: 16)
        return label
    }()
    
    let locationDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(imageContainerView)
        let dimension: CGFloat = 32
        imageContainerView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8,
            paddingBottom: 0, paddingRight: 0, width: dimension, height: dimension)
        imageContainerView.layer.cornerRadius = dimension / 2
        imageContainerView.centerY(inView: self)
        
        addSubview(locationTitleLabel)
        locationTitleLabel.anchor(top: imageContainerView.topAnchor, left: imageContainerView.rightAnchor, bottom: nil, right:
           nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(locationDistanceLabel)
        locationDistanceLabel.anchor(top: locationTitleLabel.bottomAnchor, left: imageContainerView.rightAnchor, bottom: imageContainerView.bottomAnchor,
            right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        addSubview(directionsButton)
//        let buttonDimension: CGFloat = 50
//        directionsButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0,
//            paddingBottom: 0, paddingRight: 8, width: buttonDimension, height: buttonDimension)
//        directionsButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
//    @objc func handleGetDirections () {
//        guard let mapItem = self.mapItem else { return }
//        delegate?.getDirections(forMapItem: mapItem)
//    }
        // MARK: - helper function
    
//    func animateButtonIn() {
//        directionsButton.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0,
//                        options: .curveEaseInOut, animations: {
//            self.directionsButton.alpha = 1
//            self.directionsButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//        }) { (_) in
//            self.directionsButton.transform = .identity
//        }
//    }
    func configureCell() {
        locationTitleLabel.text = mapItem?.name
        
        let distanceFormatter = MKDistanceFormatter() // عندما تحتاج إلى عرض المسافات للمستخدم
        distanceFormatter.unitStyle = .abbreviated
        guard let mapItemLocation = mapItem?.placemark.location else { return }
        guard let distanceFromUser = delegate?.distanceFromUser(location: mapItemLocation) else { return }
        let distanceAsStringy = distanceFormatter.string (fromDistance: distanceFromUser)
        locationDistanceLabel.text = distanceAsStringy
    }
}
