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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Organcell", for: indexPath) as! OrganDonationCell
        let orgDonation = organ[indexPath.row]
        cell.nameLabel.text = "الاسم: \(orgDonation.name)"
        cell.idLabel.text = "الهوية الوطنية: \(orgDonation.id)"
        cell.genderLabel.text = "الجنس : \(orgDonation.gender)"
        cell.birthdayLabel.text = "يوم الميلاد : \(orgDonation.birthday)"
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let orgDonation = organ[indexPath.row]
        let alertController = UIAlertController(title:"Ubdate", message:"ubdate your information", preferredStyle:.alert)
        let updateAction = UIAlertAction(title: "Update", style:.default){(_) in
            let id = orgDonation.id
            let name =  alertController.textFields?[0].text
            let gender = orgDonation.gender
            let birthday = orgDonation.birthday
            OrganDonationService.shared.updatevolunteer(
                volunteers: OrganModel(
                    name: name!,
                    id: id,
                    gender: gender,
                    birthday: birthday
                    
                ))
        }
        let deleteAction = UIAlertAction(title: "Delete", style:.default){(_) in
            OrganDonationService.shared.deletevolunteer(volunteerId: orgDonation.id)
        }
        alertController.addTextField{(textField) in
            textField.text = orgDonation.name
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        present (alertController, animated:true, completion: nil)
    }
}
