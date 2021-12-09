//
//  NamesDonorsVC.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit

class AttendantVC : UIViewController {
     
    var attendant : Array<AttendantModel> = []
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 280,height: 15))

        private var attendantsCV: UICollectionView?
    
        lazy var AddAttendantsButton: UIButton = {
                let b = UIButton()
                b.addTarget(self, action: #selector(addAttendant), for: .touchUpInside)
                b.translatesAutoresizingMaskIntoConstraints = false
                b.setTitle(NSLocalizedString("volunteer", comment: ""), for: .normal)
                b.layer.cornerRadius = 25
                b.setTitleColor(UIColor(red: (76/255), green: (133/255), blue: (104/255), alpha: 1), for: .normal)
                b.titleLabel?.font = UIFont(name: "Avenir-Light", size: 18)
                b.backgroundColor = .systemGray5
                return b
            }()
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            AttendantService.shared.listenToAttendant{ newAttendant in
                self.attendant = newAttendant
                self.attendantsCV!.reloadData()
            }
 
            let leftNavBarButton = UIBarButtonItem(customView: searchBar)
              self.navigationItem.rightBarButtonItem = leftNavBarButton
           searchBar.searchBarStyle = UISearchBar.Style.default
           searchBar.placeholder = NSLocalizedString("Search", comment: "")
           searchBar.sizeToFit()
           searchBar.isTranslucent = false
           searchBar.delegate = self
           view.addSubview(searchBar)
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.itemSize = CGSize(width: 320,
                                     height: 150)
            attendantsCV = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout)
            
            guard let attendantsCV = attendantsCV else {
                return
            }
            
            attendantsCV.register(DonorsCell.self, forCellWithReuseIdentifier: "cell")
            attendantsCV.dataSource = self
            attendantsCV.delegate = self
            attendantsCV.backgroundColor = UIColor (named: "Color")
            view.addSubview(attendantsCV)
            attendantsCV.frame = view.bounds

            
            view.addSubview(searchBar)
            NSLayoutConstraint.activate([
                searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
            
            view.addSubview(AddAttendantsButton)
                   NSLayoutConstraint.activate([
                    AddAttendantsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
                    AddAttendantsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
                    AddAttendantsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
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
    var selectedIndexx = -1

    extension AttendantVC: UICollectionViewDelegate  , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               return CGSize(width: 350, height: 200)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return attendant.count
        }
        
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonorsCell
            
                let atendant = attendant[indexPath.row]
                
            cell.nameLabel.text = " الاسم:\(atendant.name)"
                cell.bloodLabel.text = "العمر:\(atendant.age)"
            cell.idLabel.text = " الهويه الوطنيه:  \(atendant.id)"
            cell.numberLabel.text = "رقم الهاتف:  \(atendant.num)"
        
            return cell
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
            if searchText.isEmpty {
                let temp = attendant
                attendant = temp
                
                AttendantService.shared.listenToAttendant{ newAttendant in
                    self.attendant = newAttendant
                    self.attendantsCV!.reloadData()
                }
                
            } else {
                
                attendant = attendant.filter({ oneProduct in
                    return oneProduct.name.starts(with: searchText)
                })
            }
            attendantsCV?.reloadData()
            
        }
        
    }

    func searchBarCancelButton(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
