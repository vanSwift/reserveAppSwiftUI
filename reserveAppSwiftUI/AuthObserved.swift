//
//  AuthObserved.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 28.01.2025.
//

import Foundation

extension AuthPage{
    @Observable
    class Observed{
        var currentProfile: Profile?
        func auth(email: String, password: String){
            Task{
                let profile = try await AuthService.shared.signIn(email: email, password: password)
                await MainActor.run { self.currentProfile = profile }
            }
        }
        
        func signUp(email: String, password: String, confirm: String){
            guard password == confirm else { return }
            Task{
                let profile = try await AuthService.shared.signUp(email: email, password: password)
                await MainActor.run { self.currentProfile = profile }
            }
        }
    }
}
