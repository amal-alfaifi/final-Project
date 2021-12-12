//
//  AnimationViewController.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
  let animationView = AnimationView()
  static let animation = "81548-loading"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startAnimation()
    handleAnimation()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  func startAnimation () {
    animationView.animation = Animation.named(AnimationViewController.animation)
    animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
    animationView.center = view.center
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .loop
    animationView.play()
    view.addSubview(animationView)
  }
    func handleAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let loginView = LogInVC()
              self.navigationController?.pushViewController(loginView, animated: true)
          }
        }

}
