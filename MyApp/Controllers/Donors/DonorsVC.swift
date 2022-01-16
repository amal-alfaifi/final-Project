//
//  information.swift
//  MyApp
//
//  Created by Amal on 04/05/1443 AH.
//

import UIKit
import ContactsUI
import FirebaseFirestore
import FirebaseAuth
import Lottie

class DonorsVC : UIViewController, CNContactViewControllerDelegate {
    let db = Firestore.firestore()

    var donors: Array<DonorsModel> = []
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
    
    lazy var donorsCV: UICollectionView = {
        var donorsCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        donorsCV.delegate = self
        donorsCV.dataSource = self
        donorsCV.register(DonorsCell.self, forCellWithReuseIdentifier: "cell")
        donorsCV.backgroundColor = UIColor (named: "Color")
        donorsCV.translatesAutoresizingMaskIntoConstraints = false
        donorsCV.frame = view.bounds
        return donorsCV
    }()
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        donorsCV = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return layout
    }()
    
    
    lazy var AddDonorButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(AddDonor), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(NSLocalizedString("new donor", comment: ""), for: .normal)
        b.layer.cornerRadius = 25
        b.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        b.backgroundColor = .systemGray5
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DonorsService.shared.listenToDonors{ newdonor in
            self.donors = newdonor
            self.donorsCV.reloadData()
        }
        
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        
        view.addSubview(donorsCV)
        NSLayoutConstraint.activate([
            donorsCV.topAnchor.constraint(equalTo: view.topAnchor),
            donorsCV.leftAnchor.constraint(equalTo: view.leftAnchor),
            donorsCV.rightAnchor.constraint(equalTo: view.rightAnchor),
            donorsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.addSubview(AddDonorButton)
        NSLayoutConstraint.activate([
            AddDonorButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            AddDonorButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            AddDonorButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            AddDonorButton.widthAnchor.constraint(equalToConstant: 400),
            AddDonorButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
    }
    
    @objc func AddDonor() {
        let vc = NewDonor()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DonorsVC: UICollectionViewDelegate  , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donors.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addData(donorss: donors[indexPath.row])
    }
    func collectionView( _ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(String(describing: index))" as NSString
        return UIContextMenuConfiguration( identifier: identifier, previewProvider: nil) { _ in
            let editAction = UIAction(
                title: "Edit",
                image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    let donorss = self.donors[indexPath.row]
                    
                    let alertController = UIAlertController(title:"Ubdate", message:"ubdate your information", preferredStyle:.alert)
                    let updateAction = UIAlertAction(title: "Update", style:.default){(_) in
                        let token = UserDefaults.standard.string(forKey: "token")

                        let id = donorss.id
                        let name =  alertController.textFields?[0].text
                        let bloodType = alertController.textFields?[2].text
                        let num =  alertController.textFields?[3].text
                        DonorsService.shared.updateDonor(
                            doners: DonorsModel(
                                name: name!,
                                id: id,
                                bloodType: bloodType!,
                                num: num!, userID: token!
                                
                            ))
                    }
                    alertController.addTextField{(textField) in
                        textField.text = donorss.name
                    }
                    alertController.addTextField{(textField) in
                        textField.text = donorss.id
                    }
                    alertController.addTextField{(textField) in
                        textField.text = donorss.bloodType
                    }
                    alertController.addTextField{(textField) in
                        textField.text = donorss.num
                    }
                    alertController.addAction(updateAction)
                    let token = UserDefaults.standard.string(forKey: "token")
                    if token == donorss.userID {
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
                    let donorss = self.donors[indexPath.row]
                    let alertController = UIAlertController(title:"Delete", message:"Delete Information", preferredStyle:.alert)
                    let deleteAction = UIAlertAction(title: "Delete", style:.default){(_) in
                        DonorsService.shared.deleteDonor(donorId: donorss.id)
                    }
                    alertController.addAction (deleteAction)
                    let token = UserDefaults.standard.string(forKey: "token")
                    if token == donorss.userID {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonorsCell
        let donorss = donors[indexPath.row]
        cell.nameLabel.text = "الاسم: \(donorss.name)"
        cell.idLabel.text = "الهوية الوطنية: \(donorss.id)"
        cell.numberLabel.text = "رقم الهاتف: \(donorss.num)"
        cell.bloodLabel.text = "فصيلة الدم : \(donorss.bloodType)"
        cell.delegate = self
        return cell
    }
    /*
     Func
     تفتح صفحة حفظ بيانات الشخص
     */
    func addData(donorss: DonorsModel) {
        let con = CNMutableContact()
        con.givenName = donorss.name
        con.familyName = " "
        con.phoneNumbers.append(CNLabeledValue(
            label: "", value: CNPhoneNumber(stringValue: donorss.num)))
        let unkvc = CNContactViewController(forUnknownContact: con)
        unkvc.contactStore = CNContactStore()
        unkvc.delegate = self
        unkvc.allowsActions = false
        self.navigationController?.pushViewController(unkvc, animated: true)
    }
    // البحث بفصيلة الدم
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            let temp = donors
//            donors = temp
//            DonorsService.shared.listenToDonors{ newdonor in
//                self.donors = newdonor
//                self.donorsCV.reloadData()
//            }
//        } else {
//            donors = donors.filter({ oneAttendant in
//                return oneAttendant.bloodType.starts(with: searchText)
//            })
//            donorsCV.reloadData()
//        }
//    }
//}
//func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//    searchBar.resignFirstResponder()
//}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchText.isEmpty {
                    let temp = donors
                    donors = temp

                    DonorsService.shared.listenToDonors{ NewDonor in
                        self.donors = NewDonor
                        self.donorsCV.reloadData()
                    }

                } else {

                    donors = donors.filter({ oneDonor in
                        return oneDonor.bloodType.starts(with: searchText)
                    })
                }
                donorsCV.reloadData()

            }

        }

        func searchBarCancelButtonCliced(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()

        }

//
extension DonorsVC : CellDelegate {
    func didTapButton(cell: DonorsCell, didTappedThe button: UIButton?) {
        guard let indexPath = donorsCV.indexPath(for: cell) else {return}
        addData(donorss: donors[indexPath.row])
    }
}
