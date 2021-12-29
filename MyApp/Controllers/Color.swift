//
//  Color.swift
//  MyApp
//
//  Created by Amal on 04/05/1443 AH.
//

import UIKit
import Foundation

// الوان متدرجه للخلفيه

enum colors {
    static let button = UIColor(red:0.58, green:0.26, blue:0.25, alpha:1.0)
    
    static let backgroundDarckcolor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    static let backgroundLightcolor = UIColor(red: (143/255), green: (204/255), blue: (173/255), alpha: 1)
    static let textFieldsBorder = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
    static let textFieldsBackground = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
    static let titlesColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
}


extension UIView {
    
    /*
     func
     تجمع الالوان المتدرجه
     */
    
    func setGradiantView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colors.backgroundDarckcolor.cgColor, colors.backgroundLightcolor.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

