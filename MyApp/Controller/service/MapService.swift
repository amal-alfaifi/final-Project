//
//  MapService.swift
//  MyApp
//
//  Created by Amal on 10/05/1443 AH.
//

import Foundation
import FirebaseFirestore

class MapService {
    static let shared = MapService()
    
    let MapCollection = Firestore.firestore().collection("Hospital")
    
    func listenToLocation(completion: @escaping ((HospitalModel) -> Void)) {
        
        MapCollection.addSnapshotListener{ snapshot, error in
            if error != nil {
                return
            }
            guard let documents = snapshot?.documents else { return }
            var location: Array<HospitalModel> = hospital
            for document in documents {
                let data = document.data()
                let locationn = HospitalModel(
                    name: (data["name"] as? String) ?? "No name",
                    id: (data["id"] as? String) ?? "No id",
                    image: (data["image"] as? String) ?? "No image"

                )
                location.append(locationn)
            }
//            completion(location)
        }
    }
}
