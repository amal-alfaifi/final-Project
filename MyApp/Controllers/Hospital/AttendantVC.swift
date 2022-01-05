//
//  NamesDonorsVC.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit
import ContactsUI
import FirebaseFirestore
import FirebaseAuth

class AttendantVC : UIViewController,CNContactViewControllerDelegate {
    let db = Firestore.firestore()

    var attendant : Array<AttendantModel> = []
    weak var delegate: CellDelegate?
    lazy var searchBar : UISearchBar = {
        let s = UISearchBar(frame: CGRect(x: 0, y: 0, width: 280,height: 15))
        s.searchBarStyle = UISearchBar.Style.default
        s.placeholder = NSLocalizedString("Search", comment: "")
        s.sizeToFit()
        s.isTranslucent = false
        s.delegate = self
        return s
    }()
    
    lazy var attendantsCV: UICollectionView = {
        var attendantsCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        attendantsCV.delegate = self
        attendantsCV.dataSource = self
        attendantsCV.register(AttendantCell.self, forCellWithReuseIdentifier: "cellA")
        attendantsCV.backgroundColor = UIColor (named: "Color")
        attendantsCV.translatesAutoresizingMaskIntoConstraints = false
        attendantsCV.frame = view.bounds
        return attendantsCV
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        attendantsCV = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return layout
    }()
    
    lazy var AddAttendantsButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(addAttendant), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(NSLocalizedString("volunteer", comment: ""), for: .normal)
        b.layer.cornerRadius = 25
        b.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        b.backgroundColor = .systemGray5
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let passed = UserDefaults.standard.string(forKey: "hospital")
        AttendantService.shared.listenToAttendant{ newAttendant in
            let filteredArray = newAttendant.filter { $0.hospitalName == passed }
            
            self.attendant = filteredArray
            self.attendantsCV.reloadData()
        }
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.addSubview(attendantsCV)
        NSLayoutConstraint.activate([
            attendantsCV.topAnchor.constraint(equalTo: view.topAnchor),
            attendantsCV.leftAnchor.constraint(equalTo: view.leftAnchor),
            attendantsCV.rightAnchor.constraint(equalTo: view.rightAnchor),
            attendantsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        view.addSubview(AddAttendantsButton)
        NSLayoutConstraint.activate([
            AddAttendantsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            AddAttendantsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            AddAttendantsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            AddAttendantsButton.widthAnchor.constraint(equalToConstant: 400),
            AddAttendantsButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    @objc func addAttendant() {
        let vc = NewAttendant()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AttendantVC: UICollectionViewDelegate  , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attendant.count
    }
    func collectionView( _ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(String(describing: index))" as NSString
        return UIContextMenuConfiguration( identifier: identifier, previewProvider: nil) { _ in
            let editAction = UIAction(
                title: "Edit",
                image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    let atendant = self.attendant[indexPath.row]
                    let passed = UserDefaults.standard.string(forKey: "hospital")
                    let alertController = UIAlertController(title:"Ubdate", message:"ubdate your information", preferredStyle:.alert)
                    let updateAction = UIAlertAction(title: "Update", style:.default){(_) in
                        let token = UserDefaults.standard.string(forKey: "token")

                        let id = atendant.id
                        let name =  alertController.textFields?[0].text
                        let age = alertController.textFields?[2].text
                        let num =  alertController.textFields?[3].text
                        AttendantService.shared.updateAttendant(
                            attendants: AttendantModel(
                                name: name!,
                                id: id,
                                age: age!,
                                num: num!,
                                hospitalName: passed!, userID: token!
                                
                            ))
                    }
                    alertController.addTextField{(textField) in
                        textField.text = atendant.name
                    }
                    alertController.addTextField{(textField) in
                        textField.text = atendant.id
                    }
                    alertController.addTextField{(textField) in
                        textField.text = atendant.age
                    }
                    alertController.addTextField{(textField) in
                        textField.text = atendant.num
                    }
                    alertController.addAction(updateAction)
                    let token = UserDefaults.standard.string(forKey: "token")
                    if token == atendant.userID {
                        self.present (alertController, animated:true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Not Your Data", message: "Can't Edit", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present (alert, animated:true, completion: nil)
                    }
                }
            let deleteAction = UIAction(
                title: "Delete",
                image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                    let atendant = self.attendant[indexPath.row]
                    let alertController = UIAlertController(title:"Delete", message:"Delete Information", preferredStyle:.alert)
                    let deleteAction = UIAlertAction(title: "Delete", style:.default){(_) in
                        AttendantService.shared.deleteAttendant(attendantrId: atendant.id)
                    }
                    alertController.addAction (deleteAction)
                    let token = UserDefaults.standard.string(forKey: "token")
                    if token == atendant.userID {
                        self.present (alertController, animated:true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Not Your Data", message: "Can't Edit", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present (alert, animated:true, completion: nil)
                    }
                }
            return UIMenu(title: "", image: nil, children: [editAction, deleteAction])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellA", for: indexPath) as! AttendantCell
        
        let atendant = attendant[indexPath.row]
        
        cell.nameLabel.text = " الاسم:\(atendant.name)"
        cell.ageLabel.text = "العمر:\(atendant.age)"
        cell.idLabel.text = " الهويه الوطنيه:  \(atendant.id)"
        cell.numberLabel.text = "رقم الهاتف:  \(atendant.num)"
        cell.delegate = self
        return cell
    }
    func addData() {
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
                                    let name = data["name"] as? String
                                    let phone = data["phone"] as? String
                                    let con = CNMutableContact()
                                    con.givenName = name ?? ""
                                    con.familyName = " "
                                    con.phoneNumbers.append(CNLabeledValue(
                                        label: "", value: CNPhoneNumber(stringValue: phone ?? "")))
                                    let unkvc = CNContactViewController(forUnknownContact: con)
                                    unkvc.message = "He knows his trees"
                                    unkvc.contactStore = CNContactStore()
                                    unkvc.delegate = self
                                    unkvc.allowsActions = false
                                    self.navigationController?.pushViewController(unkvc, animated: true)
                                }}}}}}
    }
    func addData(attendants: AttendantModel) {
        let con = CNMutableContact()
        con.givenName = attendants.name
        con.familyName = " "
        con.phoneNumbers.append(CNLabeledValue(
            label: "", value: CNPhoneNumber(stringValue: attendants.num)))
        let unkvc = CNContactViewController(forUnknownContact: con)
        unkvc.contactStore = CNContactStore()
        unkvc.delegate = self
        unkvc.allowsActions = false
        self.navigationController?.pushViewController(unkvc, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let passed = UserDefaults.standard.string(forKey: "hospital")
        if searchText.isEmpty {
            let temp = attendant
            attendant = temp
            
            AttendantService.shared.listenToAttendant{ newAttendant in
                let filteredArray = newAttendant.filter { $0.hospitalName == passed }
                self.attendant = filteredArray
                self.attendantsCV.reloadData()
            }
        } else {
            let filteredArray = attendant.filter { $0.hospitalName == passed }
            attendant = filteredArray.filter({ oneAttendant in
                return oneAttendant.name.starts(with: searchText)
            })
        }
        attendantsCV.reloadData()
        
    }
}
func searchBarCancelButton(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
}

extension AttendantVC : CellDelegateA {
    func didTapButton(cell: AttendantCell, didTappedThe button: UIButton?) {
        guard let indexPath = attendantsCV.indexPath(for: cell) else {
            return
        }
        addData(attendants: attendant[indexPath.row])
    }
}
