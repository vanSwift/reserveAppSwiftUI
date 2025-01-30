//
//  AuthService.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 28.01.2025.
//

import Foundation
import FirebaseAuth

actor AuthService{
    static let shared = AuthService(); private init(){}
    
    let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }
    
    
    func signIn(email: String, password: String) async throws -> Profile{
        let user = try await auth.signIn(withEmail: email, password: password).user
        let profile = try await FirestoreService.shared.getProfile(id: user.uid)
        return profile
    }
    
    func signUp (email: String, password: String) async throws -> Profile{
        let user =  try await auth.createUser(withEmail: email, password: password).user
        let profile = Profile(id: user.uid, name: "", email: user.email!, phone: 0)
        return try await FirestoreService.shared.createProfile(profile)
    }
    func SignOut(){
       try? auth.signOut()
    }
}
