//
//  Login.swift
//  JetChat
//
//  Created by MacBook on 08/04/1443 AH.
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
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var emailTF : ViewController =  {
        $0.textFiled.text = "Amal@gmail.com"
        $0.textFiled.placeholder = (NSLocalizedString("email", comment: "")).localized()
        $0.icon.image   = UIImage(named: "email")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ViewController())
    
    lazy var passTf : ViewController =  {
        $0.textFiled.text = "123456"
        $0.textFiled.placeholder = (NSLocalizedString("password", comment: "")).localized()
        $0.textFiled.textAlignment = .center
        $0.icon.image   = UIImage(named: "password")
        $0.textFiled.translatesAutoresizingMaskIntoConstraints = false
        $0.textFiled.isSecureTextEntry = true
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
        
        self.view.addSubview(stack)
        
        self.stack.addArrangedSubview(passTf)
        self.stack.addArrangedSubview(nameTF)
        self.stack.addArrangedSubview(emailTF)
        
        view.addSubview(registerBtn)
        view.addSubview(loginRegstSg)
        view.addSubview(greenImage)
        NSLayoutConstraint.activate([
            greenImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            greenImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            greenImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            greenImage.widthAnchor.constraint(equalToConstant: 100),
            greenImage.heightAnchor.constraint(equalToConstant: 300),
        ])
        NSLayoutConstraint.activate([
            loginRegstSg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegstSg.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loginRegstSg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        NSLayoutConstraint.activate([
            self.stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stack.topAnchor.constraint(equalTo: self.loginRegstSg.bottomAnchor, constant: 40),
            self.stack.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100),
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
                    print(error?.localizedDescription)
                }
                guard let user = result?.user else {return}
                
                self.db.collection("users").document(user.uid).setData([
                    "name": self.nameTF,
                    "email": String(user.email!),
                    "userID": user.uid
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
                    self.present(vc, animated: true, completion: nil)
                    
                } else {
                    // If I have a error
                    print(error?.localizedDescription)
                }}}}
    
    
    
    @objc func loginRegstSgChg() {
        let title = loginRegstSg.titleForSegment(at: loginRegstSg.selectedSegmentIndex)
        registerBtn.setTitle(title, for: .normal)
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
