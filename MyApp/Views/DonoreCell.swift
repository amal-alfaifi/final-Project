//
//  DonoreCell.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//
import UIKit
import ContactsUI

class DonorsCell: UICollectionViewCell, CNContactViewControllerDelegate {
    
    static let identifire = "donorCell"
    
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
    
    public let bloodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 18)
        return label
    }()
    public let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "a"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Light", size: 18)
        return label
    }()
    public let phoneBtn: UIImageView = {
        let btn = UIImageView()
        btn.image = UIImage(named: "pppp")
        return btn
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
            contentView.clipsToBounds = true
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 13
         
  
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(bloodLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(phoneBtn)
        
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
        
        
        numberLabel.frame = CGRect(x: 45,
                              y: 90,
                              width: 300,
                              height: contentView.frame.size.height-30)
        
        phoneBtn.frame = CGRect(x: 300,
                              y: 20,
                              width: 50,
                              height: contentView.frame.size.height-150)
      
        bloodLabel.frame = CGRect(x: 50,
                              y: 50,
                              width: 300,
                              height: contentView.frame.size.height-30)

    }
}
