//
//  DonoreCell.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//
import UIKit
class DonorsCell: UICollectionViewCell {
    
    static let identifire = "Cell"
    
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
    public let phoneBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        btn.setImage(UIImage(systemName: "phone"), for: .normal)
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
        
        phoneBtn.frame = CGRect(x: 10,
                              y: 90,
                              width: 20,
                              height: contentView.frame.size.height-30)
      
        bloodLabel.frame = CGRect(x: 50,
                              y: 50,
                              width: 300,
                              height: contentView.frame.size.height-30)

    }
    @objc  func callNumber() {
        if let url = URL(string: "tel://\(numberLabel)") {
             UIApplication.shared.openURL(url)
         }
            guard let url = URL(string: "tel://\(numberLabel)"),
            UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

}
}
