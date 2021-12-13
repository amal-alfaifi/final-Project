//
//  ProfileVC.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

var user: User?
class ProfileVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    let db = Firestore.firestore()
    var users: Array<User> = []
    

    lazy var singOut: UIButton = {
        let singOut = UIButton()
        singOut.addTarget(self, action: #selector(singOutButton), for: .touchUpInside)
        singOut.setTitle((NSLocalizedString("Sign out", comment: "")), for: .normal)
        singOut.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        singOut.layer.borderColor = UIColor.gray.cgColor
        singOut.layer.borderWidth = 2
        singOut.layer.cornerRadius = 20
        singOut.translatesAutoresizingMaskIntoConstraints = false
        return singOut
    }()
    lazy var changeBtn: UIButton = {
            let b = UIButton()
        b.addTarget(self, action: #selector(change), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 5
        b.backgroundColor = .systemGray5
        b.setImage(UIImage(systemName: "dot.circle.and.hand.point.up.left.fill"), for: .normal)
        b.tintColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            return b
        }()
    lazy var changelabel: UILabel = {
            let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.text = (NSLocalizedString("change languge", comment: ""))
            return l
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

    lazy var nameP : UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.white.cgColor
        tf.textColor = .red
//        tf.text = "ggg"
        return tf
    }()
    lazy var greenImage: UIImageView = {
      let gI = UIImageView()
        gI.translatesAutoresizingMaskIntoConstraints = false
        gI.image = UIImage(named: "green")
      return gI

    }()


  override func viewDidLoad() {

      view.backgroundColor = .white

      let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
       profileImage.addGestureRecognizer(tapRecognizer)
      
//      nameP.text = user?.name
//      RegisterService.shared.listenToUsers{ newd in
//          self.users = newd
//      }
      
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
      view.addSubview(changelabel)
      NSLayoutConstraint.activate([
        changelabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10),
        changelabel.topAnchor.constraint(equalTo: greenImage.bottomAnchor, constant: 10),
        changelabel.widthAnchor.constraint(equalToConstant: 200),
        changelabel.heightAnchor.constraint(equalToConstant: 60),
      ])
      view.addSubview(changeBtn)
      NSLayoutConstraint.activate([
        changeBtn.rightAnchor.constraint(equalTo: changelabel.leftAnchor, constant:-100),
        changeBtn.topAnchor.constraint(equalTo: greenImage.bottomAnchor, constant: 30),
        changeBtn.widthAnchor.constraint(equalToConstant: 60),
        changeBtn.heightAnchor.constraint(equalToConstant: 20),
      ])
      

      view.addSubview(singOut)
      NSLayoutConstraint.activate([
        singOut.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
        singOut.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        singOut.widthAnchor.constraint(equalToConstant: 200),
        singOut.heightAnchor.constraint(equalToConstant: 50),
      ])
      fetchCurrentUsers() 
//      guard let currentUserID = Auth.auth().currentUser?.uid else {return}
//          Firestore.firestore()
//            .document("users/\(currentUserID)")
//            .addSnapshotListener{ doucument, error in
//              if error != nil {
//                print (error)
//                return
//              }
//              self.nameP.text = doucument?.data()?["name"] as? String
//            }
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
    @objc func change() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
              }
              if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                  print("Settings opened: \(success)") 
                })
              }
          }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] ?? info [.originalImage] as? UIImage
        profileImage.image = image as? UIImage
        dismiss(animated: true)
    }
    
    private func fetchCurrentUsers() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.collection("users").whereField("userEmail", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["name"] as? String,
//                               let userIsOnline = data["status"] as? String,
                               let userEmail = data["email"] as? String
                            {
                                
                                DispatchQueue.main.async {
                                    self.nameP.text = userName
//                                    self.userEmailLabel.text = userEmail
    
                                }
                            }
                        }
                    }
                }
        }
    }
}


