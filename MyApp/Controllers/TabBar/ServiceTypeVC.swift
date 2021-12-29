//
//  ServiceType.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit

class ServiceTypeVC: UIViewController {
   
lazy var bloodButton: UIButton = {
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
    btn.backgroundColor = .systemGray5
    btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
    btn.layer.borderWidth = 3
    btn.layer.cornerRadius = 12
    btn.addTarget(self, action: #selector(bloodButtonTapped), for: .touchUpInside)
    btn.setTitle((NSLocalizedString("Blood donation", comment: "")), for: .normal)
    btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
    return btn
}()
    lazy var organDonation: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(organDonationTapped), for: .touchUpInside)
        btn.setTitle((NSLocalizedString("Organ donation", comment: "")), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return btn
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "bd3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "h22")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "p")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var attendantButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.borderColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1).cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(attendantButtonTapped), for: .touchUpInside)
        btn.setTitle((NSLocalizedString("Patient facilities", comment: "")), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return btn
    }()

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = (NSLocalizedString("services", comment: ""))
    view.backgroundColor = UIColor (named: "Color-1")
    
    view.addSubview(bloodButton)
    NSLayoutConstraint.activate([
        bloodButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        bloodButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        bloodButton.widthAnchor.constraint(equalToConstant: 300),
        bloodButton.heightAnchor.constraint(equalToConstant: 200),
    ])
    
    view.addSubview(imageView)
    NSLayoutConstraint.activate([
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55),
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 155),
        imageView.widthAnchor.constraint(equalToConstant: 100),
        imageView.heightAnchor.constraint(equalToConstant: 100),
    ])
    view.addSubview(organDonation)
    NSLayoutConstraint.activate([
        organDonation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        organDonation.topAnchor.constraint(equalTo: bloodButton.bottomAnchor, constant: 20),
        organDonation.widthAnchor.constraint(equalToConstant: 300),
        organDonation.heightAnchor.constraint(equalToConstant: 200),
    ])
    
    view.addSubview(imageView3)
    NSLayoutConstraint.activate([
        imageView3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -42),
        imageView3.topAnchor.constraint(equalTo: bloodButton.bottomAnchor, constant: 80),
        imageView3.widthAnchor.constraint(equalToConstant: 100),
        imageView3.heightAnchor.constraint(equalToConstant: 100),
    ])
    
    view.addSubview(attendantButton)
    NSLayoutConstraint.activate([
        attendantButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        attendantButton.topAnchor.constraint(equalTo: organDonation.bottomAnchor, constant: 20),
        attendantButton.widthAnchor.constraint(equalToConstant: 300),
        attendantButton.heightAnchor.constraint(equalToConstant: 200),
    ])
    view.addSubview(imageView2)
    NSLayoutConstraint.activate([
        imageView2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -42),
        imageView2.topAnchor.constraint(equalTo: organDonation.bottomAnchor, constant: 60),
        imageView2.widthAnchor.constraint(equalToConstant: 100),
        imageView2.heightAnchor.constraint(equalToConstant:100),
    ])

}

@objc private func bloodButtonTapped() {
    let vc = DonorsVC()

    vc.navigationItem.largeTitleDisplayMode = .never
    vc.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func attendantButtonTapped() {
        let vc = HospitalVC()

        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        }
    @objc private func organDonationTapped() {
        let vc = OrganDonationVC()

        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        }
}
