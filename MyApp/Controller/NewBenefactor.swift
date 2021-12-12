//
//  NewBenefactor.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//

import Foundation
import FirebaseFirestore

class NewBenefactor: UIViewController, UITextFieldDelegate {
    
    lazy var infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(infoButtomItemTapped))
    
    lazy var odNameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("Donorname", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var odIdTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("National", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var odSexTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("Mobile number", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    lazy var birthTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("blood", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var addButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(add), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle((NSLocalizedString("Add", comment: "")), for: .normal)
        b.titleLabel?.font = UIFont(name: "Avenir-Light", size: 27.0)
        b.layer.cornerRadius = 25
        b.backgroundColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        return b
    }()
    
    public let LabelN: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = (NSLocalizedString("Donor's name :", comment: ""))
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .right
        
        return label
    }()
    public let LabelID: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("NDonor", comment: ""))
        label.textAlignment = .right
        
        return label
    }()
    public let sexLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("phDonor" , comment: ""))
        label.textAlignment = .right
        return label
    }()
    public let Labelbirthday: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("TDonor", comment: ""))
        label.textAlignment = .right
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "Color-2")

       navigationItem.setRightBarButton(infoBarButtonItem, animated: false)

        
        view.addSubview(addButton)
        view.addSubview(LabelN)
        view.addSubview(LabelID)
        view.addSubview(sexLabel)
        view.addSubview(Labelbirthday)
 
        LabelN.frame = CGRect(x: 155,
                             y: 200,
                             width: 200,
                             height:130)
        
        LabelID.frame = CGRect(x: 155,
                             y: 300,
                             width: 200,
                             height:130)
        
        sexLabel.frame = CGRect(x: 220,
                             y: 410,
                             width: 140,
                             height:130)
        
        Labelbirthday.frame = CGRect(x: 220,
                            y: 520,
                            width: 140,
                            height:130)
        
 
        view.addSubview(odNameTF)
        NSLayoutConstraint.activate([
            odNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            odNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 290),
            odNameTF.heightAnchor.constraint(equalToConstant: 48),
            odNameTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        
        view.addSubview(odIdTF)
        NSLayoutConstraint.activate([
            odIdTF.topAnchor.constraint(equalTo: odNameTF.topAnchor, constant: 100),
            odIdTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            odIdTF.heightAnchor.constraint(equalToConstant: 48),
            odIdTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(odSexTF)
        NSLayoutConstraint.activate([
            odSexTF.topAnchor.constraint(equalTo: odIdTF.bottomAnchor, constant: 60),
            odSexTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            odSexTF.heightAnchor.constraint(equalToConstant: 48),
            odSexTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(birthTF)
        NSLayoutConstraint.activate([
            birthTF.topAnchor.constraint(equalTo: odSexTF.bottomAnchor, constant: 60),
            birthTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthTF.heightAnchor.constraint(equalToConstant: 48),
            birthTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            addButton.widthAnchor.constraint(equalToConstant: 400),
            addButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismiss(animated: true, completion: nil)
        return true
    }
    @objc func add() {
        let name = odNameTF.text ?? ""
        let id = odIdTF.text ?? ""
        let sex = odSexTF.text ?? ""
        let birthday = birthTF.text ?? ""

        OrganDonationService.shared.addvolunteer(od: OrganModel(name: name, id: id, sex: sex , birthday: birthday))
     dismiss(animated: true, completion: nil)
        
        }
    @objc func infoButtomItemTapped() {
        let vc = InformationVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }

}
