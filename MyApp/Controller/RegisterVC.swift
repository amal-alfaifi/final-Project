//
//  RegisterVC.swift
//  MyApp
//
//  Created by Amal on 03/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var users: Array<User> = []
    
    lazy var titleLbl: UILabel = {
        $0.changeUILabel(title: (NSLocalizedString("Sign up", comment: "")), size: 20)
        return $0
         }(UILabel())
 
    lazy var nameTF: ViewController = {
        $0.textFiled.placeholder = (NSLocalizedString("first", comment: ""))
        $0.icon.image = UIImage(named: "user")
            return $0
    }(ViewController())

    lazy var emailTF:ViewController = {
        $0.textFiled.placeholder = (NSLocalizedString("email", comment: ""))
        $0.icon.image = UIImage(named: "email")
        return $0
       }(ViewController())
    
    lazy var passwordTF: ViewController = {
        $0.textFiled.placeholder = (NSLocalizedString("password", comment: ""))
        $0.icon.image = UIImage(named: "password")
        $0.textFiled.isSecureTextEntry = true
           return $0
       }(ViewController())
    
    lazy var password2TF: ViewController = {
        $0.textFiled.placeholder = (NSLocalizedString("last", comment: ""))
        $0.icon.image = UIImage(named: "password")
        $0.textFiled.isSecureTextEntry = true
           return $0
       }(ViewController())
    
    lazy var singUpBtn: UIButton = {
        $0.changeUIButton(title: (NSLocalizedString("Sign up", comment: "")), color: colors.button)
        $0.addTarget(self, action:#selector(startSignUp), for: .touchUpInside)
                return $0
    }(UIButton(type: .system))
    
    lazy var singInBtn: UIButton = {
        $0.changeUIButton(title: (NSLocalizedString("did you have account?", comment: "")) , color: .clear)
        $0.addTarget(self, action:#selector(didPresssignInButton), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
  
    
    lazy var stackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradiantView()
        
        view.addSubview(titleLbl)
        view.addSubview(singInBtn)
        view.addSubview(singUpBtn)
        //stack
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameTF)
        stackView.addArrangedSubview(emailTF)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(password2TF)
 
        NSLayoutConstraint.activate([
        
            self.titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.titleLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant:100),
             self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -80),
        
            
            self.emailTF.heightAnchor.constraint(equalToConstant: 50),
            self.passwordTF.heightAnchor.constraint(equalToConstant: 50),
            self.emailTF.heightAnchor.constraint(equalToConstant: 50),
            self.password2TF.heightAnchor.constraint(equalToConstant: 50),
            
            
            self.singUpBtn.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 30),
            self.singUpBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.singUpBtn.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.2),
            self.singUpBtn.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            self.singInBtn.topAnchor.constraint(equalTo: self.singUpBtn.bottomAnchor, constant: 5),
            self.singInBtn.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            self.singInBtn.heightAnchor.constraint(equalToConstant: 30),
            self.singInBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            

                
        ])
    }

     @objc func didPresssignInButton(_ sender : UIButton ){
        let VC = TabVC()
        VC.modalPresentationStyle = .fullScreen
        dismiss(animated: true, completion: nil)
          print("move")
      
    }
    @objc func startSignUp() {
        let email = emailTF.textFiled.text ?? ""
        let password = passwordTF.textFiled.text ?? ""
        let firstNam = nameTF.textFiled.text ?? ""
        let password2 = password2TF.textFiled.text ?? ""
        let uuid = UUID().uuidString
        
        if email.isEmpty || password.isEmpty || firstNam.isEmpty || password2.isEmpty {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error as Any)
                return
            }
        }
        
        RegisterService.shared.addUser(
            user: User(name: firstNam, id: uuid)
        )
    }
    
 
    
}

