//
//  OrganCell.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//


import UIKit
class OrganDonationCell: UICollectionViewCell {
    
    static let identifire = "Organcell"
    
    fileprivate let application = UIApplication.shared
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 20)
        return label
    }()
    
    public let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 18)
        return label
    }()
    
    public let sexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 18)
        return label
    }()
    public let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "a"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 18)
        return label
    }()

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
            contentView.clipsToBounds = true
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 13
         
  
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(sexLabel)
        contentView.addSubview(birthdayLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//left right
        nameLabel.frame = CGRect(x: 50,
                              y: -40,
                              width: 300,
                              height: contentView.frame.size.height-30)
    
    
        idLabel.frame = CGRect(x: 50,
                              y: 5,
                              width: 300,
                              height: contentView.frame.size.height-30)
        
        
        birthdayLabel.frame = CGRect(x: 45,
                              y: 90,
                              width: 300,
                              height: contentView.frame.size.height-30)
      
        sexLabel.frame = CGRect(x: 50,
                              y: 50,
                              width: 300,
                              height: contentView.frame.size.height-30)

    }

}
