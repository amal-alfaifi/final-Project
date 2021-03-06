//
//  HospitalService.swift
//  MyApp
//
//  Created by Amal on 03/05/1443 AH.
//

import Foundation
import FirebaseFirestore

class AttendantService {
    static let shared = AttendantService()
    
    let attendantCollection = Firestore.firestore().collection("Attendants")
    
    // Add Attendant
    func addAttendant(attendant: AttendantModel) {
        attendantCollection.document(attendant.id).setData([
            "name": attendant.name,
            "id": attendant.id,
            "age": attendant.age,
            "num": attendant.num,
            "hospitalID" : attendant.hospitalName ?? "",
            "userID": attendant.userID
        ])
    }
    
    // Listen to Attendant
    func listenToAttendant(completion: @escaping (([AttendantModel]) -> Void)) {
        
        attendantCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            var attendants: Array<AttendantModel> = []
            for document in documents {
                let data = document.data()
                let attendant = AttendantModel(
                    name: (data["name"] as? String) ?? "No name",
                    id: (data["id"] as? String) ?? "No id",
                    age: (data["age"] as? String) ?? "No age",
                    num: (data["num"] as? String) ?? "No num",
                    hospitalName: (data["hospitalID"] as? String) ?? "hospitalID",
                    userID: (data["userID"] as? String) ?? "userID"
                )
                attendants.append(attendant)
            }
            completion(attendants)
        }
    }
    func deleteAttendant(attendantrId: String) {
        attendantCollection.document(attendantrId).delete()
    }
    
    func updateAttendant(attendants: AttendantModel) {
        attendantCollection.document(attendants.id).setData([
            "name": attendants.name,
            "id": attendants.id,
            "age": attendants.age,
            "num": attendants.num,
            "hospitalID": attendants.hospitalName ?? "",
            "userID": attendants.userID
        ], merge: true)
    }

}
