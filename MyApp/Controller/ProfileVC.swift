//
//  ProfileVC.swift
//  JetChat
//
//  Created by ibrahim asiri on 10/04/1443 AH.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class ProfileVC: UIViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    let profileImage: UIImageView = {
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
    
    let userNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        name.textColor = .white
        name.layer.cornerRadius = 12
        name.textAlignment = .center
        //        name.layer.borderColor = UIColor.white.cgColor
        //        name.layer.borderWidth = 1
        return name
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
    lazy var greenImage: UIImageView = {
        let gI = UIImageView()
        gI.translatesAutoresizingMaskIntoConstraints = false
        gI.image = UIImage(named: "green")
        return gI
        
    }()
    lazy var darkLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.text = (NSLocalizedString("Dark mode", comment: ""))
        return l
    }()
    
    
    let signOutButton: UIButton = {
        let singOut = UIButton()
        singOut.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        singOut.setTitle((NSLocalizedString("Sign out", comment: "")).localized(), for: .normal)
        singOut.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        singOut.layer.borderColor = UIColor.gray.cgColor
        singOut.layer.borderWidth = 2
        singOut.layer.cornerRadius = 20
        singOut.translatesAutoresizingMaskIntoConstraints = false
        return singOut
    }()
    lazy var mode : UISwitch = {
        let mode = UISwitch()
        mode.addTarget(self, action: #selector(setDarkModeCell), for: .valueChanged)
        mode.isOn = true
        mode.isUserInteractionEnabled = true
        mode.translatesAutoresizingMaskIntoConstraints = false
        return mode
    }()
    @objc func setDarkModeCell (_ sender: UISwitch) {
        if mode.isOn == false {
            self.overrideUserInterfaceStyle = .dark
        } else {
            self.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor (named: "Color-1")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImage.addGestureRecognizer(tapRecognizer)
        
        title = (NSLocalizedString("Profile", comment: ""))
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        readImageFromFirestore()
        setUpLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCurrentUsers()
        
    }
    
    func setUpLabels() {
        view.addSubview(greenImage)
        NSLayoutConstraint.activate([
            greenImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0),
            greenImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            greenImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            greenImage.widthAnchor.constraint(equalToConstant: 1),
            greenImage.heightAnchor.constraint(equalToConstant: 250),
        ])
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant:270 ),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant:-280),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
        ])
        view.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.rightAnchor.constraint(equalTo: profileImage.leftAnchor, constant: -20),
            userNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            userNameLabel.widthAnchor.constraint(equalToConstant: 250),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
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
        view.addSubview(darkLabel)
        NSLayoutConstraint.activate([
            darkLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10),
            darkLabel.topAnchor.constraint(equalTo: changelabel.bottomAnchor, constant: 20),
            darkLabel.widthAnchor.constraint(equalToConstant: 200),
            darkLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        view.addSubview(mode)
        NSLayoutConstraint.activate([
            mode.rightAnchor.constraint(equalTo: darkLabel.leftAnchor, constant: 50),
            mode.topAnchor.constraint(equalTo: changeBtn.bottomAnchor, constant: 50),
            mode.widthAnchor.constraint(equalToConstant: 200),
            mode.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            signOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            signOutButton.widthAnchor.constraint(equalToConstant: 200),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
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
    
    @objc func signOutButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
        present(LogInVC(), animated: true, completion: nil)
    }
    
    @objc func imageTapped() {
        present(imagePicker, animated: true)
    }
    
    func saveImageToFirestore(url: String, userId: String) {
        db.collection("users").document(userId).setData([
            "userImageURL": url,
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }}}
    
    private func readImageFromFirestore(){
        guard let currentUser = Auth.auth().currentUser else {return}
        
        db.collection("users").whereField("email", isEqualTo: String(currentUser.email!))
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let imageURL = data["userImageURL"] as? String
                            {
                                let httpsReference = self.storage.reference(forURL: imageURL)
                                
                                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        
                                        print("ERROR GETTING DATA \(error.localizedDescription)")
                                    } else {
                                        DispatchQueue.main.async {
                                            self.profileImage.image = UIImage(data: data!)
                                        }}}
                                
                            } else {
                                print("error converting data")
                                DispatchQueue.main.async {
                                    self.profileImage.image = UIImage(systemName: "person.fill.badge.plus")
                                }}}}}}}
    
    
    private func fetchCurrentUsers() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.collection("users").whereField("email", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["name"] as? String,
                               let userEmail = data["email"] as? String
                            {
                                DispatchQueue.main.async {
                                    self.userNameLabel.text = userName
                                    
                                }}}}}}}}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
        guard let currentUser = Auth.auth().currentUser else {return}
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("UserProfileImages/\(currentUser.email!)/\(currentUser.uid).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.saveImageToFirestore(url: "\(url!)", userId: currentUser.uid)
                    
                })
            }else{
                print("error \(String(describing: error))")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
