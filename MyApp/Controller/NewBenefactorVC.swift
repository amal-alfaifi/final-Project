//
//  NewBenefactor.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import SafariServices

var sender = false
class NewBenefactor: UIViewController, UITextFieldDelegate {
    

    lazy var odNameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("dddo", comment: ""))
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
    
    lazy var genderTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("the g", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    lazy var birthTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = (NSLocalizedString("bir", comment: ""))
        tf.backgroundColor = .systemGray5
        tf.textAlignment = .right
        tf.delegate = self
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var addButton: UIButton = {
        let b = UIButton()
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
        label.text = (NSLocalizedString("dddo", comment: ""))
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
    public let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("sd" , comment: ""))
        label.textAlignment = .right
        return label
    }()
    public let Labelbirthday: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = (NSLocalizedString("bd", comment: ""))
        label.textAlignment = .right
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
    lazy var patButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(privacyPolicy), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle((NSLocalizedString("Policy and Terms", comment: "")), for: .normal)
        b.titleLabel?.font = UIFont(name: "Avenir-Light", size: 15.0)
        b.setTitleColor(UIColor.blue, for: .normal)
        return b
    }()
    lazy var checkButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        b.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "Color-2")
  
        view.addSubview(addButton)
        view.addSubview(LabelN)
        view.addSubview(LabelID)
        view.addSubview(genderLabel)
        view.addSubview(Labelbirthday)
 
        LabelN.frame = CGRect(x: 50,
                             y: 110,
                             width: 300,
                             height:130)
        
        LabelID.frame = CGRect(x: 50,
                             y: 210,
                             width: 300,
                             height:130)
        
        genderLabel.frame = CGRect(x: 55,
                             y: 320,
                             width: 300,
                             height:130)
        
        Labelbirthday.frame = CGRect(x: 220,
                            y: 420,
                            width: 140,
                            height:130)
        
  
        view.addSubview(odNameTF)
        NSLayoutConstraint.activate([
            odNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            odNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
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
        view.addSubview(genderTF)
        NSLayoutConstraint.activate([
            genderTF.topAnchor.constraint(equalTo: odIdTF.bottomAnchor, constant: 60),
            genderTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderTF.heightAnchor.constraint(equalToConstant: 48),
            genderTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(birthTF)
        NSLayoutConstraint.activate([
            birthTF.topAnchor.constraint(equalTo: genderTF.bottomAnchor, constant: 60),
            birthTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthTF.heightAnchor.constraint(equalToConstant: 48),
            birthTF.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
        view.addSubview(patButton)
        NSLayoutConstraint.activate([
            patButton.topAnchor.constraint(equalTo: birthTF.bottomAnchor, constant: 10),
            patButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            patButton.heightAnchor.constraint(equalToConstant: 40),
            patButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -260)
        ])
        view.addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: birthTF.bottomAnchor, constant: 7),
            checkButton.rightAnchor.constraint(equalTo: patButton.leftAnchor, constant: 50),
            checkButton.heightAnchor.constraint(equalToConstant: 48),
            checkButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -270)
        ])
        
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
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
     func add() {

            let name = odNameTF.text ?? ""
            let id = odIdTF.text ?? ""
            let gender = genderTF.text ?? ""
            let birthday = birthTF.text ?? ""

            OrganDonationService.shared.addvolunteer(od: OrganModel(name: name, id: id, gender: gender , birthday: birthday))
        }
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Condition",
                                      message: "You must agree to the terms.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Cancle",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    @objc func infoButtomItemTapped() {
        let vc = InformationVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
    @objc func privacyPolicy(_ sender: Any) {
        let privacyURL = "https://laws.boe.gov.sa/BoeLaws/Laws/LawDetails/4a16fbc8-7f1d-4647-8acc-ad0900d849c2/1"
        let safariVC = SFSafariViewController(url: URL(string: privacyURL)!)
        self.present(safariVC, animated: true)
      }
    @objc func checkBoxTapped(_ sender: UIButton) {
        if sender.isSelected {
           sender.isSelected = false
           sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            self.add()
        }
         else {
            sender.isSelected  = true
            sender.setImage(UIImage(systemName: "squareshape"), for: .normal)
            self.alertUserLoginError()
        }
    }

}
