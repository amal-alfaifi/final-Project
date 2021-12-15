//
//  HospitalVC.swift
//  MyApp
//
//  Created by Amal on 03/05/1443 AH.
//

import Foundation


import UIKit

class HospitalVC: UIViewController {
    
    
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
        var vc = MapVC()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
              }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) 
        let vc = AttendantVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    
        
    }
    
}
