//
//  LogIn.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController {
    
    
    //MARK: Step 1
    lazy var titlelbl: UILabel = {
        $0.changeUILabel(title: (NSLocalizedString("SIGN IN", comment: "")), size: 20)
        return $0
    }(UILabel())

    lazy var singInBtn : UIButton = {
        $0.changeUIButton(title:(NSLocalizedString("Log In", comment: "")), color: colors.button)
        $0.addTarget(self, action:#selector(tapToSignIn), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var signUpBtn : UIButton = {
        $0.changeUIButton(title: (NSLocalizedString("Don't have account?", comment: "")), color: .clear)
        $0.addTarget(self, action:#selector(didPresssignUpButton), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var emailTextFiled :  ViewController = {
        $0.textFiled.placeholder = (NSLocalizedString("email", comment: ""))
        $0.icon.image = UIImage(named: "email")
        return $0
    }(ViewController())
    
    lazy var passwordTextFiled : ViewController  = {
        $0.textFiled.placeholder  = (NSLocalizedString("password", comment: ""))
        $0.icon.image = UIImage(named: "password")
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradiantView()
        
        self.view.addSubview(titlelbl)
        self.view.addSubview(signUpBtn)
        self.view.addSubview(singInBtn)

        self.view.addSubview(stack)
        self.stack.addArrangedSubview(emailTextFiled)
        self.stack.addArrangedSubview(passwordTextFiled)
        
        //MARK: step 3
        NSLayoutConstraint.activate([
            //***
            self.titlelbl.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.titlelbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            

            //***
            self.stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stack.topAnchor.constraint(equalTo: self.titlelbl.bottomAnchor, constant: 150),
            self.stack.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100),

            //singInBtn btn
            self.singInBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.singInBtn.topAnchor.constraint(equalTo: self.stack.bottomAnchor, constant: 20),
            self.singInBtn.heightAnchor.constraint(equalToConstant: 50),
            //frame
            self.singInBtn.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.2),
            
            //signUpBtn BTN
            self.signUpBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.signUpBtn.topAnchor.constraint(equalTo: self.singInBtn.bottomAnchor, constant: 5),
            self.signUpBtn.heightAnchor.constraint(equalToConstant: 30),
            self.signUpBtn.widthAnchor.constraint(equalToConstant: self.view.frame.width),
        ])
        
    }
    
    @objc func didPresssignUpButton(_ sender: UIButton){
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    
    }
    @objc func PresssignUpButton(_ sender: UIButton){
        let vc = TabVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
}
    
    @objc private func tapToSignIn() {
        let email = self.emailTextFiled.textFiled.text ?? ""
        let password = self.passwordTextFiled.textFiled.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            return self.alertUserLoginError()
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            let vc = TabVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
         message: "Please enter your emile.",
                                preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    
}
}

