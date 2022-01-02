//
//  TabVC.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//

import UIKit

class TabVC: UITabBarController {
  fileprivate func createNavController(for rootViewController: UIViewController,
                           title: String,
                           image: UIImage) -> UIViewController {
      let navController = UINavigationController(rootViewController: rootViewController)
      navController.tabBarItem.title = title
      navController.tabBarItem.image = image
      navController.navigationBar.prefersLargeTitles = true
      rootViewController.navigationItem.title = title
      return navController
    }
  func setupVCs() {
     viewControllers = [
        createNavController(for:CitiesVC(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "homekit")!),
        createNavController(for:ProfileVC(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "person")!),
        createNavController(for:MapVC(), title: NSLocalizedString("lo", comment: ""), image: UIImage(systemName: "location")!),
 
    

     ]
   }
  override func viewDidLoad() {
    super.viewDidLoad()
      tabBar.layer.borderColor = UIColor.systemGray.cgColor
      tabBar.layer.borderWidth = 0.5
      tabBar.backgroundColor = .white
      tabBar.tintColor = .label
      setupVCs()
    
  }
}