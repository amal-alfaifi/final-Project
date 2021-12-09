//
//  ViewController.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit

class CitiesVC: UIViewController {

    lazy var asirButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.cornerRadius = 40
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.setTitle((NSLocalizedString("Aseer", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    lazy var albahaButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 40
        btn.setTitle((NSLocalizedString("Albaha", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    lazy var jazanButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 40
        btn.setTitle((NSLocalizedString("Jazan", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    lazy var najranButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 40
        btn.setTitle((NSLocalizedString("Najran", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "Color")
//        view.setGradiantView()
        
   
        view.addSubview(asirButton)
        NSLayoutConstraint.activate([
            asirButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            asirButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            asirButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            asirButton.widthAnchor.constraint(equalToConstant: 300),
            asirButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        view.addSubview(albahaButton)
        NSLayoutConstraint.activate([
            albahaButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            albahaButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            albahaButton.topAnchor.constraint(equalTo: asirButton.topAnchor, constant: 100),
            albahaButton.widthAnchor.constraint(equalToConstant: 300),
            albahaButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        view.addSubview(jazanButton)
        NSLayoutConstraint.activate([
            jazanButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            jazanButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            jazanButton.topAnchor.constraint(equalTo: albahaButton.topAnchor, constant: 100),
            jazanButton.widthAnchor.constraint(equalToConstant: 300),
            jazanButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        view.addSubview(najranButton)
        NSLayoutConstraint.activate([
            najranButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            najranButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            najranButton.topAnchor.constraint(equalTo: jazanButton.topAnchor, constant: 100),
            najranButton.widthAnchor.constraint(equalToConstant: 300),
            najranButton.heightAnchor.constraint(equalToConstant: 70),
        ])

    }

    @objc private func cityButtonTapped() {
            let vc = ServiceTypeVC()
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)

        }
    }

