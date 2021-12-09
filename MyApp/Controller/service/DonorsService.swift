//
//  DonorsServise.swift
//  MyApp
//
//  Created by Amal on 02/05/1443 AH.
//

import UIKit
import FirebaseFirestore


class DonorsService {
    static let shared = DonorsService()

    let DonersCollection = Firestore.firestore().collection("Doners")

    func addH(doners: DonorsModel) {
        DonersCollection.document(doners.id).setData([
            "name": doners.name,
            "id": doners.id,
            "blood": doners.bloodType,
            "num": doners.num
        ])
    }
    
    func listenToDonors(completion: @escaping (([DonorsModel]) -> Void)) {

        DonersCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            guard let documents = snapshot?.documents else { return }

            var donors: Array<DonorsModel> = []
            for document in documents {
                let data = document.data()
                
                let donor = DonorsModel(
                    name: (data["name"] as? String) ?? "No name",
                    id: (data["id"] as? String) ?? "No id",
                    bloodType:(data["blood"] as? String) ?? "No blood",
                    num: (data["num"] as? String) ?? "No number"
                    )
                donors.append(donor)
            }
            completion(donors)
        }
    }

}


