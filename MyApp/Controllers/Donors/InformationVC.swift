//
//  information.swift
//  MyApp
//
//  Created by Amal on 04/05/1443 AH.
//

import Foundation
import UIKit

class InformationVC : UIViewController {
    
    public let labelQ: UILabel = {
        let labelQ = UILabel()
        labelQ.translatesAutoresizingMaskIntoConstraints = false
        labelQ.layer.borderWidth = 3
        labelQ.layer.borderColor = UIColor.systemGray4.cgColor
        return labelQ
    }()
    public let labelQq: UILabel = {
        let labelQ = UILabel()
        labelQ.translatesAutoresizingMaskIntoConstraints = false
        labelQ.font = UIFont(name: "Helvetica-Bold", size: 18)
        labelQ.textColor = #colorLiteral(red: 0.1941709816, green: 0.44306916, blue: 0.2248781919, alpha: 1)
        labelQ.text = (NSLocalizedString("b", comment: ""))
        return labelQ
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.image = UIImage(named: "blood")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var informationTF: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.font = UIFont(name: "Avenir-Light", size:22)
        tv.text = (NSLocalizedString("i", comment: ""))
        tv.layer.cornerRadius = 20
        tv.allowsEditingTextAttributes = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(labelQ)
        NSLayoutConstraint.activate([
            labelQ.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            labelQ.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            labelQ.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelQ.heightAnchor.constraint(equalToConstant: 100),
            labelQ.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),

        ])

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: labelQ.topAnchor,constant: 36),
            imageView.rightAnchor.constraint(equalTo: labelQ.rightAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: labelQ.heightAnchor, constant: -70),
            imageView.widthAnchor.constraint(equalTo: labelQ.widthAnchor, constant: -280),
            ])
        view.addSubview(labelQq)
        NSLayoutConstraint.activate([
            labelQq.topAnchor.constraint(equalTo: labelQ.topAnchor,constant: 36),
            labelQq.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -20),
            labelQq.heightAnchor.constraint(equalTo: labelQ.heightAnchor, constant: -70),
            labelQq.widthAnchor.constraint(equalTo: labelQ.widthAnchor, constant: -80),
            ])
        view.addSubview(informationTF)
        NSLayoutConstraint.activate([
            informationTF.topAnchor.constraint(equalTo: labelQ.topAnchor,constant: 100),
            informationTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            informationTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            informationTF.heightAnchor.constraint(equalToConstant: 700),
            informationTF.widthAnchor.constraint(equalToConstant: 150),
            
        ])
    }
}

