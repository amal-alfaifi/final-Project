//
//  Login.swift
//  MyApp
//
//  Created by Amal on 08/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInVC: UIViewController {
    
    //dataBase
    let db = Firestore.firestore()
    
    lazy var greenImage: UIImageView = {
        let gI = UIImageView()
        gI.translatesAutoresizingMaskIntoConstraints = false
        gI.image = UIImage(named: "ato")
        return gI
        
    }()
    lazy var nameTF : ViewController = {
        $0.textFiled.text = "Amal".localized()
        $0.textFiled.placeholder = (NSLocalizedString("name1", comment: "")).localized()
        $0.icon.image   = UIImage(named: "user")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var emailTF : ViewController =  {
        $0.textFiled.text = "Amal@gmail.net"
        $0.textFiled.placeholder = (NSLocalizedString("email", comment: "")).localized()
        $0.icon.image   = UIImage(named: "email")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var passTf : ViewController =  {
        $0.textFiled.text = "1234567"
        $0.textFiled.placeholder = (NSLocalizedString("password", comment: "")).localized()
        $0.textFiled.textAlignment = .center
        $0.icon.image   = UIImage(named: "password")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.textFiled.translatesAutoresizingMaskIntoConstraints = false
        $0.textFiled.isSecureTextEntry = true
        return $0
    }(ViewController())
    lazy var bloodTypeTf : ViewController =  {
        $0.textFiled.placeholder = (NSLocalizedString("blood type", comment: "")).localized()
        $0.icon.image   = UIImage(named: "bllo")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var genderTF : ViewController =  {
//        $0.textFiled.text = "Female"
        $0.textFiled.placeholder = (NSLocalizedString("gen", comment: "")).localized()
        $0.icon.image   = UIImage(named: "gr")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var phoneTF : ViewController =  {
//        $0.textFiled.text = "+996342423"
        $0.textFiled.placeholder = (NSLocalizedString("phN", comment: "")).localized()
        $0.icon.image   = UIImage(named: "فون")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var idTF : ViewController =  {
        $0.textFiled.placeholder = (NSLocalizedString("vn", comment: "")).localized()
        $0.icon.image   = UIImage(named: "user")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var ageTF : ViewController =  {
//        $0.textFiled.text = "25"
        $0.textFiled.placeholder = (NSLocalizedString("Date of Birth", comment: "")).localized()
        $0.icon.image   = UIImage(named: "icons8-plus-1-day-50")
        $0.textFiled.font = UIFont(name: "", size: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var stack : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    let registerBtn : UIButton = {
        let registerBtn = UIButton()
        registerBtn.backgroundColor = UIColor(red:0.58, green:0.26, blue:0.25, alpha:1.0)
        registerBtn.setTitle((NSLocalizedString("Sign up", comment: "")).localized(), for: .normal)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.layer.cornerRadius = 25
        registerBtn.addTarget(self, action: #selector(loginRigs), for: .touchUpInside)
        return registerBtn
    }()
    
    var loginRegstSg : UISegmentedControl = {
        let loginRegstSg = UISegmentedControl(items: [(NSLocalizedString("Log In", comment: "")).localized(), (NSLocalizedString("Sign up", comment: "")).localized()])
        loginRegstSg.selectedSegmentIndex = 1
        loginRegstSg.backgroundColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        loginRegstSg.translatesAutoresizingMaskIntoConstraints = false
        loginRegstSg.addTarget(self, action: #selector(loginRegstSgChg), for:  .valueChanged)
        return loginRegstSg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradiantView()
        let text = NSLocalizedString("Sign up", comment: "").localized()
        if registerBtn.titleLabel?.text == text {
            registerUI ()
        } else {
            loginUI ()
        }
    }
    
    func registerUI () {
        self.view.addSubview(stack)
        self.stack.addArrangedSubview(emailTF)
        self.stack.addArrangedSubview(nameTF)
        self.stack.addArrangedSubview(passTf)
        self.stack.addArrangedSubview(bloodTypeTf)
        self.stack.addArrangedSubview(ageTF)
        self.stack.addArrangedSubview(genderTF)
        self.stack.addArrangedSubview(phoneTF)
        self.stack.addArrangedSubview(idTF)
        view.addSubview(registerBtn)
        view.addSubview(loginRegstSg)
        greenImage.removeFromSuperview()
        NSLayoutConstraint.activate([
            loginRegstSg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegstSg.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            loginRegstSg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        NSLayoutConstraint.activate([
            self.stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stack.topAnchor.constraint(equalTo: self.loginRegstSg.bottomAnchor, constant: 20),
            self.stack.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100),
        ])
        NSLayoutConstraint.activate([
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerBtn.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 25),
            registerBtn.widthAnchor.constraint(equalToConstant: 330),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
  
    func loginUI () {
        self.view.addSubview(stack)
        self.stack.addArrangedSubview(emailTF)
        self.stack.addArrangedSubview(nameTF)
        self.stack.addArrangedSubview(passTf)
        self.stack.removeArrangedSubview(bloodTypeTf)
        self.stack.removeArrangedSubview(ageTF)
        self.stack.removeArrangedSubview(genderTF)
        self.stack.removeArrangedSubview(phoneTF)
        self.stack.removeArrangedSubview(idTF)
        bloodTypeTf.removeFromSuperview()
        ageTF.removeFromSuperview()
        genderTF.removeFromSuperview()
        phoneTF.removeFromSuperview()
        idTF.removeFromSuperview()
        nameTF.removeFromSuperview()
        view.addSubview(registerBtn)
        view.addSubview(loginRegstSg)

        NSLayoutConstraint.activate([
            loginRegstSg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegstSg.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loginRegstSg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        NSLayoutConstraint.activate([
            self.stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stack.topAnchor.constraint(equalTo: self.loginRegstSg.bottomAnchor, constant: 200),
            self.stack.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 100),
        ])
        NSLayoutConstraint.activate([
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerBtn.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 70),
            registerBtn.widthAnchor.constraint(equalToConstant: 330),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    //كيف يتغير segment من دخول لتسجيل دخول
    @objc func loginRigs() {
        if loginRegstSg.selectedSegmentIndex == 0 {
            login()
        }else {
            register()
        }
    }
    
    // register by firebase
    @objc func register(){
        
        if let email = emailTF.textFiled.text, email.isEmpty == false,
           let password = passTf.textFiled.text, password.isEmpty == false {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to vc
                    let vc = TabVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                } else {
                    // If I have a error
                    let alert = UIAlertController(title: "Error", message: "Email is Used By Some One Else", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { action in
                        //
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                guard let user = result?.user else {return}
                UserDefaults.standard.set(user.uid, forKey: "token")
                self.db.collection("users").document(user.uid).setData([
                    "name": self.nameTF.textFiled.text,
                    "email": String(user.email!),
                    "userID": user.uid,
                    "bloodType": self.bloodTypeTf.textFiled.text,
                    "age": self.ageTF.textFiled.text,
                    "ID": self.idTF.textFiled.text,
                    "phone": self.phoneTF.textFiled.text,
                    "gender": self.genderTF.textFiled.text
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }}}}}
    
    
    // login by firebase
    func login() {
        if let email = emailTF.textFiled.text, email.isEmpty == false,
           let password = passTf.textFiled.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to main vc
                    let vc = TabVC()
                    vc.modalPresentationStyle = .fullScreen
                    guard let user = result?.user else {return}
                    UserDefaults.standard.set(user.uid, forKey: "token")
                    self.present(vc, animated: true, completion: nil)
                } else {
                    // If I have a error
                    let alert = UIAlertController(title: "Error", message: "User Not Found Please Sign Up", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { action in
                        //
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }}}}
    
    
    
    @objc func loginRegstSgChg() {
        let title = loginRegstSg.titleForSegment(at: loginRegstSg.selectedSegmentIndex)
        registerBtn.setTitle(title, for: .normal)
        let text = NSLocalizedString("Sign up", comment: "").localized()
        if registerBtn.titleLabel?.text == text {
            registerUI ()
        } else {
            loginUI ()
        }
    }}

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "localized",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
