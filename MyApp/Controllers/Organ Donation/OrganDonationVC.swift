//
//  organDonationVC.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//

import UIKit


class OrganDonationVC : UIViewController {
    
    var organ: Array<OrganModel> = []
    
    lazy var odCV: UICollectionView = {
        var odCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        odCV.delegate = self
        odCV.dataSource = self
        odCV.register(OrganDonationCell.self, forCellWithReuseIdentifier: "Organcell")
        odCV.backgroundColor = UIColor (named: "Color")
        odCV.translatesAutoresizingMaskIntoConstraints = false
        odCV.frame = view.bounds
        return odCV
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        odCV = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OrganDonationService.shared.listenTovolunteer{ new in
            self.organ = new
            self.odCV.reloadData()
        }
        
        view.addSubview(odCV)
        NSLayoutConstraint.activate([
            odCV.topAnchor.constraint(equalTo: view.topAnchor),
            odCV.leftAnchor.constraint(equalTo: view.leftAnchor),
            odCV.rightAnchor.constraint(equalTo: view.rightAnchor),
            odCV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension OrganDonationVC: UICollectionViewDelegate  , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return organ.count
    }
    
    func collectionView( _ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(String(describing: index))" as NSString
        return UIContextMenuConfiguration( identifier: identifier, previewProvider: nil) { _ in
            let editAction = UIAction(
                title: NSLocalizedString("Edit", comment: ""),
                image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    let orgDonation = self.organ[indexPath.row]
                    
                    let alertController = UIAlertController(title:(NSLocalizedString("Ubdate", comment: "")), message:(NSLocalizedString("ubdate your information", comment: "")), preferredStyle:.alert)
                    let updateAction = UIAlertAction(title: (NSLocalizedString("Ubdate", comment: "")), style:.default){(_) in
                        let token = UserDefaults.standard.string(forKey: "token")
                        let id = orgDonation.id
                        let name =  alertController.textFields?[0].text
                        let gender = orgDonation.gender
                        let birthday = orgDonation.birthday
                        OrganDonationService.shared.updatevolunteer(
                            volunteers: OrganModel(
                                name: name!,
                                id: id,
                                gender: gender,
                                birthday: birthday, userID: token!
                                
                            ))
                    }
                    alertController.addTextField{(textField) in
                        textField.text = orgDonation.name
                    }
                    alertController.addAction(updateAction)
                    let token = UserDefaults.standard.string(forKey: "token")
                    if token == orgDonation.userID {
                        self.present (alertController, animated:true, completion: nil)
                    }
                }
            let deleteAction = UIAction(
                title: NSLocalizedString("Delete", comment: ""),
                image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                    let orgDonation = self.organ[indexPath.row]
                    let alertController = UIAlertController(title: (NSLocalizedString("Delete", comment: "")), message:(NSLocalizedString("Delete Information", comment: "")), preferredStyle:.alert)
                    let deleteAction = UIAlertAction(title: (NSLocalizedString("Delete", comment: "")), style:.default){(_) in
                        OrganDonationService.shared.deletevolunteer(volunteerId: orgDonation.id)
                    }
                    alertController.addAction (deleteAction)
                    let token = UserDefaults.standard.string(forKey: "token")
                    if token == orgDonation.userID {
                        self.present (alertController, animated:true, completion: nil)
                    } 
                }
            return UIMenu(title: "", image: nil, children: [editAction, deleteAction])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Organcell", for: indexPath) as! OrganDonationCell
        let orgDonation = organ[indexPath.row]
        cell.nameLabel.text = "الاسم: \(orgDonation.name)"
        cell.idLabel.text = "الهوية الوطنية: \(orgDonation.id)"
        cell.genderLabel.text = "الجنس : \(orgDonation.gender)"
        cell.birthdayLabel.text = "تاريخ الميلاد : \(orgDonation.birthday)"
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alertController = UIAlertController(title:(NSLocalizedString("Do you want to donate organs after death?", comment: "")), message:(NSLocalizedString("Donate🫁", comment: "")), preferredStyle: .alert)
        
    let logoutAction = UIAlertAction(title: (NSLocalizedString("Yes", comment: "")), style: .destructive) { action in
        let vc = NewBenefactorVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    alertController.addAction(logoutAction)

    let cancelAction = UIAlertAction(title: (NSLocalizedString("No", comment: "")), style: .cancel) { (action) in
    }
    alertController.addAction(cancelAction)
    present(alertController, animated: true) {

    }}
}
