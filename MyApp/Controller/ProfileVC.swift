//
//  ProfileVC.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var users: User?

    lazy var singOut: UIButton = {
        let singOut = UIButton()
        singOut.addTarget(self, action: #selector(singOutButton), for: .touchUpInside)
        singOut.setTitle("Sign out", for: .normal)
        singOut.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        singOut.layer.borderColor = UIColor.gray.cgColor
        singOut.layer.borderWidth = 2
        singOut.layer.cornerRadius = 20
        singOut.translatesAutoresizingMaskIntoConstraints = false
        return singOut
    }()
    
    lazy var profileImage: UIImageView = {
       let pI = UIImageView()
        pI.translatesAutoresizingMaskIntoConstraints = false
        pI.layer.cornerRadius = 45
        pI.isUserInteractionEnabled = true
        pI.contentMode = .scaleAspectFit
        pI.clipsToBounds = true
        pI.layer.borderColor = UIColor.white.cgColor
        pI.layer.borderWidth = 1
                              
       return pI
   }()
    lazy var imagePicker : UIImagePickerController = {
       let iP = UIImagePickerController()
        iP.delegate = self
        iP.sourceType = .photoLibrary
        iP.allowsEditing = true
       return iP
   }()

    lazy var nameP : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.text = users?.name
        tf.layer.borderColor = UIColor.white.cgColor
        return tf
    }()
    lazy var greenImage: UIImageView = {
      let gI = UIImageView()
        gI.translatesAutoresizingMaskIntoConstraints = false
        gI.image = UIImage(named: "green")
      return gI

    }()


  override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .white

      let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
       profileImage.addGestureRecognizer(tapRecognizer)
      
    
      view.addSubview(greenImage)
      NSLayoutConstraint.activate([
        greenImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0),
        greenImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        greenImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        greenImage.widthAnchor.constraint(equalToConstant: 1),
        greenImage.heightAnchor.constraint(equalToConstant: 200),
      ])
      view.addSubview(profileImage)
      NSLayoutConstraint.activate([
        profileImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
        profileImage.widthAnchor.constraint(equalToConstant: 100),
        profileImage.heightAnchor.constraint(equalToConstant: 100),
      ])
      view.addSubview(nameP)
      NSLayoutConstraint.activate([
        nameP.rightAnchor.constraint(equalTo: profileImage.leftAnchor, constant: -20),
        nameP.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
        nameP.widthAnchor.constraint(equalToConstant: 220),
        nameP.heightAnchor.constraint(equalToConstant: 50),
      ])

      view.addSubview(singOut)
      NSLayoutConstraint.activate([
        singOut.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
        singOut.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        singOut.widthAnchor.constraint(equalToConstant: 200),
        singOut.heightAnchor.constraint(equalToConstant: 50),
      ])

  }
    @objc func singOutButton() {
        let vc = LogInVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        }
    @objc func imageTapped() {
        print("Image tapped")
        present(imagePicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] ?? info [.originalImage] as? UIImage
        profileImage.image = image as? UIImage
        dismiss(animated: true)
    }
}
