//
//  HospitalName.swift
//  MyApp
//
//  Created by Amal on 03/05/1443 AH.
//

import Foundation

class HospitalModel {
    var name : String
    var id : String
    var image : String
    
    init(name:String , id:String,image:String){
        self.name = name
        self.id = id
        self.image = image
    }
}
let hospital = [
    HospitalModel(name:(NSLocalizedString( "Aseer central hospital", comment: "")), id: "1", image: "Aseer"),
                
                HospitalModel(name:(NSLocalizedString( "King faisal", comment: "")), id: "2", image: "faisal"),
                
                HospitalModel(name: (NSLocalizedString( "Uhud Rafidah", comment: "")) , id: "3", image: "الصحه"),
                
                HospitalModel(name:(NSLocalizedString( "Mustasharak Hospital", comment: ""))  , id: "4", image: "m"),
                
                HospitalModel(name: (NSLocalizedString("German Hospital", comment: "")) , id: "5", image: "الماني"),
                
                HospitalModel(name: (NSLocalizedString("Saudi Specialist", comment: "")) , id: "6", image: "الصحه"),
                
                HospitalModel(name: (NSLocalizedString( "Khamis Mushait", comment: "")), id: "7", image: "خميس"),
                
                HospitalModel(name: (NSLocalizedString( "Mahayel", comment: "")) , id: "8", image: "الصحه"),
                
                HospitalModel(name: (NSLocalizedString( "German Hospital" , comment: "")), id: "5", image: "الماني"),
                
                HospitalModel(name: (NSLocalizedString( "German Hospital", comment: "")) , id: "5", image: "الماني"),

]
