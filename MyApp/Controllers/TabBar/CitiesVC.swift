//
//  ViewController.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit
protocol Cities {
    
}
class CitiesVC: UIViewController {

    lazy var asirButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.cornerRadius = 40
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.setTitle((NSLocalizedString("Abha", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    
    lazy var khamisButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 40
        btn.setTitle((NSLocalizedString("kh", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    
    lazy var uhodButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 40
        btn.setTitle((NSLocalizedString("u", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    lazy var mahayalButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 40
        btn.setTitle((NSLocalizedString("m", comment: "")), for: .normal)
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        return btn
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "zi1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "Color")
        title = (NSLocalizedString("City", comment: ""))
        view.addSubview(asirButton)
        NSLayoutConstraint.activate([
            asirButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            asirButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            asirButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            asirButton.widthAnchor.constraint(equalToConstant: 300),
            asirButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        view.addSubview(khamisButton)
        NSLayoutConstraint.activate([
            khamisButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            khamisButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            khamisButton.topAnchor.constraint(equalTo: asirButton.topAnchor, constant: 100),
            khamisButton.widthAnchor.constraint(equalToConstant: 300),
            khamisButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        view.addSubview(uhodButton)
        NSLayoutConstraint.activate([
            uhodButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            uhodButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            uhodButton.topAnchor.constraint(equalTo: khamisButton.topAnchor, constant: 100),
            uhodButton.widthAnchor.constraint(equalToConstant: 300),
            uhodButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        view.addSubview(mahayalButton)
        NSLayoutConstraint.activate([
            mahayalButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            mahayalButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            mahayalButton.topAnchor.constraint(equalTo: uhodButton.topAnchor, constant: 100),
            mahayalButton.widthAnchor.constraint(equalToConstant: 300),
            mahayalButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 118),
//            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])

    }

    @objc private func cityButtonTapped() {
            let vc = ServiceTypeVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)

        }
    }


