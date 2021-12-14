//
//  NamesDonorsVC.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit
import ContactsUI

class AttendantVC : UIViewController,CNContactViewControllerDelegate {
     
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
            
            attendantsCV.register(AttendantCell.self, forCellWithReuseIdentifier: "cellA")
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
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellA", for: indexPath) as! AttendantCell
            
                let atendant = attendant[indexPath.row]
                
            cell.nameLabel.text = " الاسم:\(atendant.name)"
             cell.ageLabel.text = "العمر:\(atendant.age)"
            cell.idLabel.text = " الهويه الوطنيه:  \(atendant.id)"
            cell.numberLabel.text = "رقم الهاتف:  \(atendant.num)"
            cell.myTabelViewController = self
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let atendant = attendant[indexPath.row]
            
            let alertController = UIAlertController(title:"Ubdate & Delete", message:"ubdate your information", preferredStyle:.alert)
            
            let updateAction = UIAlertAction(title: "Update", style:.default){(_) in
                
                let id = atendant.id
                let name =  alertController.textFields?[0].text
                let age = alertController.textFields?[2].text
                let num =  alertController.textFields?[3].text
                AttendantService.shared.updateAttendant(
                    attendants: AttendantModel(
                        name: name!,
                        id: id,
                        age: age!,
                        num: num!
                        
                    ))
            }
            let deleteAction = UIAlertAction(title: "Delete", style:.default){(_) in
                
                AttendantService.shared.deleteAttendant(attendantrId: atendant.id)
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
            alertController.addAction (deleteAction)
            present (alertController, animated:true, completion: nil)
        
            }
        func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
            if contact == nil {
                navigationController?.popViewController(animated: true)
            }
        }
        
        func CallCell(cell: UICollectionViewCell){
            let callAction = UIAlertAction(title: "Call", style:.default){(_) in
            }
                let controller = CNContactViewController(forNewContact: nil)
                controller.delegate = self
                self.navigationController?.pushViewController(controller, animated: true)
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
                
                attendant = attendant.filter({ oneAttendant in
                    return oneAttendant.name.starts(with: searchText)
                })
            }
            attendantsCV?.reloadData()
            
        }
        
    }

    func searchBarCancelButton(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
