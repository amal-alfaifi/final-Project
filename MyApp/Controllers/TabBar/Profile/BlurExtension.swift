//
//  blur.swift
//  MyApp
//
//  Created by Amal on 25/05/1443 AH.
//

import UIKit

extension UIView {
    
    func addBlurToview() {
        var blurEffect: UIBlurEffect!
       if #available(ioS 10.0, *) {
            blurEffect = UIBlurEffect(style: .dark)
         } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        // class UIVisualEffectView
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 0.8
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurredEffectView)
    }
    func removeBlurFromView() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
}
        }
    }
}
