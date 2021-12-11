//
//  NewAttendant.swift
//  MyApp
//
//  Created by Amal on 03/05/1443 AH.
//

import UIKit
import FirebaseFirestore

class NewAttendant: UIViewController, UITextFieldDelegate {
    
    lazy var attendantNameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = NSLocalizedString("volunteer name", comment: "")
        tf.backgroundColor = .systemGray5
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var attendantIdTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = NSLocalizedString("National", comment: "")
        tf.backgroundColor = .systemGray5
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var attendantNumTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = NSLocalizedString("Mobile number", comment: "")
        tf.backgroundColor = .systemGray5
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    lazy var ageTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = NSLocalizedString("age", comment: "")
        tf.backgroundColor = .systemGray5
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var addButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(add), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(NSLocalizedString("Add", comment: ""), for: .normal)
        b.titleLabel?.font = UIFont(name: "Avenir-Light", size: 27.0)
        b.layer.cornerRadius = 25
        b.backgroundColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        return b
    }()
    
    public let LabelN: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = NSLocalizedString("vname", comment: "")
        return label
    }()
    public let LabelID: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = NSLocalizedString("vn", comment: "")
        return label
    }()
    public let LabelNum: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = NSLocalizedString("vnum", comment: "")
        return label
    }()
    
    public let LabelAge: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = NSLocalizedString("age", comment: "")
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "zi1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
 
    @objc func add() {
        let name = attendantNameTF.text ?? ""
        let id = attendantIdTF.text ?? ""
        let num = attendantNumTF.text ?? ""
        let age = ageTF.text ?? ""

        AttendantService.shared.addAttendant(attendant: AttendantModel(name: name, id: id, age:age , num: num))
     dismiss(animated: true, completion: nil)

        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(LabelN)
        view.addSubview(LabelID)
        view.addSubview(LabelNum)
        view.addSubview(LabelAge)
        view.backgroundColor = UIColor (named: "Color-2")

        view.addSubview(addButton)
        
        
        LabelN.frame = CGRect(x: 50,
                             y: 100,
                             width: 300,
                             height:130)
        
        LabelID.frame = CGRect(x: 50,
                             y: 200,
                             width: 300,
                             height:130)
        
        LabelNum.frame = CGRect(x: 70,
                             y: 320,
                             width: 300,
                             height:130)
        
        LabelAge.frame = CGRect(x: 70,
                            y: 420,
                            width: 300,
                            height:130)
        
        
        view.addSubview(attendantNameTF)
        NSLayoutConstraint.activate([
            attendantNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attendantNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            attendantNameTF.heightAnchor.constraint(equalToConstant: 48),
            attendantNameTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
    
        view.addSubview(attendantIdTF)
        NSLayoutConstraint.activate([
            attendantIdTF.topAnchor.constraint(equalTo: attendantNameTF.topAnchor, constant: 100),
            attendantIdTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attendantIdTF.heightAnchor.constraint(equalToConstant: 48),
            attendantIdTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(attendantNumTF)
        NSLayoutConstraint.activate([
            attendantNumTF.topAnchor.constraint(equalTo: attendantIdTF.bottomAnchor, constant: 60),
            attendantNumTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attendantNumTF.heightAnchor.constraint(equalToConstant: 48),
            attendantNumTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(ageTF)
        NSLayoutConstraint.activate([
            ageTF.topAnchor.constraint(equalTo: attendantNumTF.bottomAnchor, constant: 60),
            ageTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTF.heightAnchor.constraint(equalToConstant: 48),
            ageTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            addButton.widthAnchor.constraint(equalToConstant: 400),
            addButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismiss(animated: true, completion: nil)
        return true
    }
    
}
