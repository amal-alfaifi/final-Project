//
//  namesDonorsModel.swift
//  MyApp
//
//  Created by Amal on 01/05/1443 AH.
//

import UIKit

class DonorsModel {
    let name: String
    let id: String
    let bloodType: String
    let num : String
    let userID: String
    
    init(name:String , id: String , bloodType: String , num: String , userID: String){
        self.name = name
        self.id = id
        self.bloodType = bloodType
        self.num = num
        self.userID = userID
    }
}
