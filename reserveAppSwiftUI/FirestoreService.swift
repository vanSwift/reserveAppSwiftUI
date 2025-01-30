//
//  FirestoreService.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 28.01.2025.
//

import Foundation
import FirebaseFirestore

actor FirestoreService{
    static let shared = FirestoreService(); private init(){}
    let db = Firestore.firestore()
    var profiles: CollectionReference { db.collection("profiles") }
    
    func createProfile(_ profile: Profile) async throws ->Profile{
       try await profiles.document(profile.id).setData(profile.representation)
        return profile
    }
    
    func getProfile(id: String) async throws -> Profile{
        let snapshot = try await profiles.document(id).getDocument()
        guard let representation = snapshot.data() else { throw DataBaseError.dataNotFound
        }
        guard let profile = Profile(representation: representation)
        else{ throw DataBaseError.wrongData
        }
        return profile
    }
    
}

enum DataBaseError: Error{
    case dataNotFound
    case wrongData
}
