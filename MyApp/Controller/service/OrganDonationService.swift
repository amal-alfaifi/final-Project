//
//  OrganDonationService.swift
//  MyApp
//
//  Created by Amal on 08/05/1443 AH.
//

import Foundation

import FirebaseFirestore

class OrganDonationService {
    static let shared = OrganDonationService()
    
    let oDCollection = Firestore.firestore().collection("OrganDonation")
    
    // Add Attendant
    func addvolunteer(od: OrganModel) {
        oDCollection.document(od.id).setData([
            "name": od.name,
            "id": od.id,
            "gender": od.gender,
            "birthday": od.birthday,
        ])
    }
    
    // Listen to Attendant
    func listenTovolunteer(completion: @escaping (([OrganModel]) -> Void)) {
        
        oDCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            var org: Array<OrganModel> = []
            for document in documents {
                let data = document.data()
                let organ = OrganModel(
                    name: (data["name"] as? String) ?? "No name",
                    id: (data["id"] as? String) ?? "No id",
                    gender: (data["gender"] as? String) ?? "Nothing",
                    birthday: (data["birthday"] as? String) ?? "Nothing"
                )
                org.append(organ)
            }
            completion(org)
        }
    }
    func deletevolunteer(volunteerId: String) {
        oDCollection.document(volunteerId).delete()
    }
    
    func updatevolunteer(volunteers: OrganModel) {
        oDCollection.document(volunteers.id).setData([
            "name": volunteers.name,
            "id": volunteers.id,
        ], merge: true)
    }

}
