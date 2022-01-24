//
//  HospitalVC.swift
//  MyApp
//
//  Created by Amal on 03/05/1443 AH.
//

import Foundation


import UIKit

class HospitalVC: UIViewController {
    var hospital = [HospitalModel]()
    var passedHospital: String?
    func addHospitals () {
        hospital.append(HospitalModel(name:(NSLocalizedString( "Aseer central hospital", comment: "")), id: "1", image: "Aseer"))
        hospital.append(  HospitalModel(name:(NSLocalizedString( "King faisal", comment: "")), id: "2", image: "faisal"))
        hospital.append(HospitalModel(name: (NSLocalizedString( "Uhud Rafidah", comment: "")) , id: "3", image: "الصحه"))
        hospital.append(HospitalModel(name:(NSLocalizedString( "Mustasharak Hospital", comment: ""))  , id: "4", image: "m"))
        hospital.append(HospitalModel(name: (NSLocalizedString("German Hospital", comment: "")) , id: "5", image: "الماني"))
        hospital.append(HospitalModel(name: (NSLocalizedString("Saudi Specialist", comment: "")) , id: "6", image: "الصحه"))
        hospital.append(HospitalModel(name: (NSLocalizedString( "Khamis Mushait", comment: "")), id: "7", image: "خميس"))
        hospital.append(  HospitalModel(name: (NSLocalizedString( "Mahayel", comment: "")) , id: "8", image: "الصحه"))
        hospital.append(HospitalModel(name: (NSLocalizedString( "German Hospital" , comment: "")), id: "5", image: "الماني"))
        hospital.append(HospitalModel(name: (NSLocalizedString( "German Hospital" , comment: "")), id: "5", image: "الماني"))
    }
    
    lazy var hospitalTV : UITableView = {
        let hospitalTV = UITableView()
        hospitalTV.register(UITableViewCell.self, forCellReuseIdentifier: "hospitalCell")
        hospitalTV.translatesAutoresizingMaskIntoConstraints = false
        hospitalTV.backgroundColor = UIColor (named: "Color-1")
        hospitalTV.dataSource = self
        hospitalTV.delegate = self
        return hospitalTV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHospitals () 
        navigationItem.title = (NSLocalizedString("Hospital", comment: ""))
        
        view.addSubview(hospitalTV)
        NSLayoutConstraint.activate([
            hospitalTV.topAnchor.constraint(equalTo: view.topAnchor),
            hospitalTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            hospitalTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            hospitalTV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let tap = UISwipeGestureRecognizer(
                target: self,
                action: #selector(hospitalLocation)
        )
        tap.direction = .right
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }

}

extension HospitalVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospital.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalCell", for: indexPath)
        let hospital = hospital[indexPath.row]
        cell.textLabel?.text = hospital.name
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        cell.imageView?.image = UIImage(named:hospital.image)
        cell.backgroundColor = UIColor (named: "Color-1")
        return cell
    }
    @objc func hospitalLocation() {
        var vc = MapController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
              }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: - willSelectRowAt
    //المستخدم يحدد صف
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        passedHospital = hospital[indexPath.row].id
        return indexPath
    }
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) 
        let vc = AttendantVC()
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.set(hospital[indexPath.row].id, forKey: "hospital")
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
