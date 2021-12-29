//
//  ProfileVC.swift
//  MyApp
//
//  Created by Amal on 10/04/1443 AH.
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
        pI.layer.cornerRadius = 34
        pI.isUserInteractionEnabled = true
        pI.contentMode = .scaleAspectFit
        pI.clipsToBounds = true
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
        name.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        name.textColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        name.layer.cornerRadius = 12
        name.textAlignment = .center

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
        gI.layer.borderColor = UIColor.gray.cgColor
        gI.layer.borderWidth = 2
        gI.layer.cornerRadius = 15
        return gI
    }()
    lazy var darkLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.text = (NSLocalizedString("Dark mode", comment: ""))
        return l
    }()
    lazy var blurLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.text = (NSLocalizedString("E", comment: ""))
        return l
    }()
    lazy var phone: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.text = (NSLocalizedString("", comment: ""))
        return l
    }()
    lazy var phonelabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.textColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        l.text = (NSLocalizedString("رقم الهاتف", comment: ""))
        return l
    }()
    lazy var bloodType: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        return l
    }()
    lazy var bloodTypelabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.textColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        l.text = (NSLocalizedString("فصيلة الدم", comment: ""))
        return l
    }()
    lazy var Age: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right

        return l
    }()
    lazy var Agelabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.textColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        l.text = (NSLocalizedString("تاريخ الميلاد", comment: ""))
        return l
    }()
    lazy var id: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.textColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        return l
    }()
    lazy var Gender: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        return l
    }()
    lazy var Genderlabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1)
        l.text = (NSLocalizedString("الجنس", comment: ""))
        l.textAlignment = .right
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
            self.view.window?.overrideUserInterfaceStyle = .dark
        } else {
            self.view.window?.overrideUserInterfaceStyle = .light
        }
    }
    lazy var mode1 : UISwitch = {
        let mode = UISwitch()
        mode.addTarget(self, action: #selector(blurEffect), for: .valueChanged)
        mode.isOn = true
        mode.isUserInteractionEnabled = true
        mode.translatesAutoresizingMaskIntoConstraints = false
        return mode
    }()
    @objc func blurEffect (_ sender: UISwitch) {
        if mode1.isOn == false {
            profileImage.addBlurToview()
        } else {
            profileImage.removeBlurFromView()
        }
    }
    @objc func changeUserName () {
        print("OK")
        let alert = UIAlertController(title: "Change UserName", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            let name =  alert.textFields?[0].text
            self.userNameLabel.text = name
            guard let currentUserID = Auth.auth().currentUser?.uid else {return}
            Firestore.firestore().document("users/\(currentUserID)").updateData([
                "name" : self.userNameLabel.text,
                "id" : currentUserID])
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { field in
            field.text = self.userNameLabel.text
        }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeUserName))
        userNameLabel.addGestureRecognizer(tap)
        userNameLabel.isUserInteractionEnabled = true
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
            greenImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            greenImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            greenImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            greenImage.widthAnchor.constraint(equalToConstant: 1),
            greenImage.heightAnchor.constraint(equalToConstant: 300),
        ])
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant:290),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant:-320),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
        ])
        view.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.rightAnchor.constraint(equalTo: profileImage.leftAnchor, constant: 29),
            userNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            userNameLabel.widthAnchor.constraint(equalToConstant: 250),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        view.addSubview(id)
        NSLayoutConstraint.activate([
            id.rightAnchor.constraint(equalTo: profileImage.leftAnchor, constant: -30),
            id.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: -5),
            id.widthAnchor.constraint(equalToConstant: 200),
            id.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        view.addSubview(Genderlabel)
        NSLayoutConstraint.activate([
            Genderlabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30),
            Genderlabel.leftAnchor.constraint(equalTo: greenImage.rightAnchor, constant: -60),
        ])
        view.addSubview(Gender)
        NSLayoutConstraint.activate([
            Gender.leftAnchor.constraint(equalTo: greenImage.rightAnchor, constant:-50),
            Gender.topAnchor.constraint(equalTo: Genderlabel.bottomAnchor, constant: 10),
        ])

        view.addSubview(Agelabel)
        NSLayoutConstraint.activate([
            Agelabel.topAnchor.constraint(equalTo: Gender.bottomAnchor, constant: 30),
            Agelabel.leftAnchor.constraint(equalTo: greenImage.rightAnchor, constant: -90),
        ])
        view.addSubview(Age)
        NSLayoutConstraint.activate([
            Age.leftAnchor.constraint(equalTo: greenImage.rightAnchor, constant:-90),
            Age.topAnchor.constraint(equalTo: Agelabel.bottomAnchor, constant: 10),
        ])
        view.addSubview(bloodTypelabel)
        NSLayoutConstraint.activate([
            bloodTypelabel.topAnchor.constraint(equalTo: greenImage.bottomAnchor, constant: -180),
            bloodTypelabel.rightAnchor.constraint(equalTo: greenImage.leftAnchor, constant: 120),
])
        view.addSubview(bloodType)
        NSLayoutConstraint.activate([
            bloodType.rightAnchor.constraint(equalTo: greenImage.leftAnchor, constant:100),
            bloodType.topAnchor.constraint(equalTo: bloodTypelabel.bottomAnchor, constant: 10),
        ])
        view.addSubview(phonelabel)
        NSLayoutConstraint.activate([
            phonelabel.topAnchor.constraint(equalTo: bloodType.bottomAnchor, constant: 28),
            phonelabel.rightAnchor.constraint(equalTo: greenImage.leftAnchor, constant: 120),
        ])
        view.addSubview(phone)
        NSLayoutConstraint.activate([
            phone.topAnchor.constraint(equalTo: phonelabel.bottomAnchor, constant: 14),
            phone.rightAnchor.constraint(equalTo: greenImage.leftAnchor, constant: 120),
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
            changeBtn.topAnchor.constraint(equalTo: greenImage.bottomAnchor, constant: 25),
            changeBtn.widthAnchor.constraint(equalToConstant: 60),
            changeBtn.heightAnchor.constraint(equalToConstant: 30),
        ])
        view.addSubview(darkLabel)
        NSLayoutConstraint.activate([
            darkLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10),
            darkLabel.topAnchor.constraint(equalTo: changelabel.bottomAnchor, constant: -10),
            darkLabel.widthAnchor.constraint(equalToConstant: 200),
            darkLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        view.addSubview(blurLabel)
        NSLayoutConstraint.activate([
            blurLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant:-10),
            blurLabel.topAnchor.constraint(equalTo: darkLabel.bottomAnchor, constant: -5),
            blurLabel.widthAnchor.constraint(equalToConstant: 200),
            blurLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        view.addSubview(mode)
        NSLayoutConstraint.activate([
            mode.rightAnchor.constraint(equalTo: darkLabel.leftAnchor, constant: 50),
            mode.topAnchor.constraint(equalTo: changeBtn.bottomAnchor, constant: 23),
            mode.widthAnchor.constraint(equalToConstant: 200),
            mode.heightAnchor.constraint(equalToConstant: 60),
        ])
        view.addSubview(mode1)
        NSLayoutConstraint.activate([
            mode1.rightAnchor.constraint(equalTo: darkLabel.leftAnchor, constant: 50),
            mode1.topAnchor.constraint(equalTo: changeBtn.bottomAnchor, constant: 80),
            mode1.widthAnchor.constraint(equalToConstant: 200),
            mode1.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            signOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
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
        UserDefaults.standard.removeObject(forKey: "token")
        let vc = LogInVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
                                    self.Gender.text =  data["gender"] as? String ?? ""
                                    self.bloodType.text = data["bloodType"] as? String  ?? ""
                                    self.id.text = data["ID"] as? String  ?? ""
                                    self.phone.text = data["phone"] as? String  ?? ""
                                    self.Age.text = data["age"] as? String  ?? ""
                                }}}}}}
        
    }
    
}

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


