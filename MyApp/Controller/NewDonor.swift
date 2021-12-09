//
//  NewName.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit
import FirebaseFirestore

class NewDonor: UIViewController, UITextFieldDelegate {
    var a: DonorsModel?
    
    lazy var infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(infoButtomItemTapped))
    
    lazy var mtbr3NameTF: UITextField = {
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
    
    lazy var mtbr3IdTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("National", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var mtbr3NumTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("Mobile number", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    lazy var bloodTF: UITextField = {
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
    public let LabelNum: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("phDonor" , comment: ""))
        label.textAlignment = .right
        return label
    }()
    public let LabelBlood: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("TDonor", comment: ""))
        label.textAlignment = .right
        return label
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "bd")
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "Color-2")

       navigationItem.setRightBarButton(infoBarButtonItem, animated: false)

        
        view.addSubview(addButton)
        view.addSubview(LabelN)
        view.addSubview(LabelID)
        view.addSubview(LabelNum)
        view.addSubview(LabelBlood)
     
        
        
        LabelN.frame = CGRect(x: 155,
                             y: 200,
                             width: 200,
                             height:130)
        
        LabelID.frame = CGRect(x: 155,
                             y: 300,
                             width: 200,
                             height:130)
        
        LabelNum.frame = CGRect(x: 220,
                             y: 410,
                             width: 140,
                             height:130)
        
        LabelBlood.frame = CGRect(x: 220,
                            y: 520,
                            width: 140,
                            height:130)
        
 
        view.addSubview(mtbr3NameTF)
        NSLayoutConstraint.activate([
            mtbr3NameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mtbr3NameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 290),
            mtbr3NameTF.heightAnchor.constraint(equalToConstant: 48),
            mtbr3NameTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: -30),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: LabelN.topAnchor, constant: -10)
        ])
    
        view.addSubview(mtbr3IdTF)
        NSLayoutConstraint.activate([
            mtbr3IdTF.topAnchor.constraint(equalTo: mtbr3NameTF.topAnchor, constant: 100),
            mtbr3IdTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mtbr3IdTF.heightAnchor.constraint(equalToConstant: 48),
            mtbr3IdTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(mtbr3NumTF)
        NSLayoutConstraint.activate([
            mtbr3NumTF.topAnchor.constraint(equalTo: mtbr3IdTF.bottomAnchor, constant: 60),
            mtbr3NumTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mtbr3NumTF.heightAnchor.constraint(equalToConstant: 48),
            mtbr3NumTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(bloodTF)
        NSLayoutConstraint.activate([
            bloodTF.topAnchor.constraint(equalTo: mtbr3NumTF.bottomAnchor, constant: 60),
            bloodTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bloodTF.heightAnchor.constraint(equalToConstant: 48),
            bloodTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
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
        let name = mtbr3NameTF.text ?? ""
        let id = mtbr3IdTF.text ?? ""
        let num = mtbr3NumTF.text ?? ""
        let bloodType = bloodTF.text ?? ""

        DonorsService.shared.addH(doners: DonorsModel(name: name, id: id, bloodType:bloodType , num: num))
     dismiss(animated: true, completion: nil)

        }
    @objc func infoButtomItemTapped() {
        let vc = InformationVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }

}
