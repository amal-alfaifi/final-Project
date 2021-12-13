//
//  organDonationVC.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//

import UIKit


class OrganDonationVC : UIViewController {
    
    var organ: Array<OrganModel> = []
    
    private var odCV: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OrganDonationService.shared.listenTovolunteer{ new in
            self.organ = new
            self.odCV!.reloadData()
        }
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: 320,
                                 height: 150)
        odCV = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        
        guard let odCV = odCV else {
            return
        }
        
        odCV.register(OrganDonationCell.self, forCellWithReuseIdentifier: "Organcell")
        odCV.dataSource = self
        odCV.delegate = self
        odCV.backgroundColor = UIColor (named: "Color")
        view.addSubview(odCV)
        odCV.frame = view.bounds
        
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
        cell.nameLabel.text = "Name: \(orgDonation.name)"
        cell.idLabel.text = "National Identity: \(orgDonation.id)"
        cell.sexLabel.text = "The gender : \(orgDonation.gender)"
        cell.birthdayLabel.text = "birthday : \(orgDonation.birthday)"
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alertController = UIAlertController(title: "Do you want to donate organs after death?", message: "Donate🫁", preferredStyle: .alert)
        
    let logoutAction = UIAlertAction(title: "Yes", style: .destructive) { action in
        let vc = NewBenefactor()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    alertController.addAction(logoutAction)

    let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in

    }

    alertController.addAction(cancelAction)
    present(alertController, animated: true) {

    }
        
    }
    
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
