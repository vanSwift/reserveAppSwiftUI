//
//  File.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 27.01.2025.
//

import Foundation
import SwiftUI

struct LeafeTextField: View{
    let title: String
    var isSecure: Bool
    @Binding var text: String
    @State private var isSecureField: Bool
    
    init(title: String, isSecure: Bool, text: Binding<String>) {
        self.title = title
        self.isSecure = isSecure
        self._text = text
        self.isSecureField = isSecure
    }
    
    
    var body: some View{
        HStack{
            if isSecureField {
                SecureField(title, text: $text)
                    .padding(.leading, 25)
            }
            else {
                TextField(title, text: $text)
                    .padding(.leading, 25)

            }
            Spacer()
            if isSecure{
                Button {
                    isSecureField.toggle()
                } label: {
                    Image(systemName:  isSecureField ? "eye" : "eye.slash" )
                        .resizable()
                        .frame(width: 26, height: 16)
                        .bold()
                        .tint(.purpleBottom)
                        .padding(.trailing)
                }

            }
        }
        .frame(height: 60)
        .background{
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25, bottomLeading: 0, bottomTrailing: 25, topTrailing: 0))
                
                .foregroundStyle(.white)
                .overlay(content: {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25, bottomLeading: 0, bottomTrailing: 25, topTrailing: 0))
                        .stroke(.black.opacity(0.3), lineWidth: 1)
                })
                
        }
    }
}





struct AuthPage: View {
   // @Bindable var appState: RouteView.Observed
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State var isAuth: Bool = true
    @Bindable var routeObserved: RouteView.Observed
    @State private var observed: Observed = Observed()
    var body: some View {
        
        VStack {
            VStack{
                Image("logo")
                    .padding(.bottom, 27)
                Text("BookMaster")
                    .font(.title.bold())
                    .foregroundStyle(.blueButton)
                LeafeTextField(title: "Введіть ваш Email", isSecure: false, text: $email)
                    .padding(.vertical, 6)
                LeafeTextField(title: "Введіть ваш пароль", isSecure: true, text: $password)
                if !isAuth{
                    LeafeTextField(title: "Підтвердіть ваш пароль", isSecure: true, text: $confirmPassword)
                }
                Button{
                    if isAuth{
                        observed.auth(email: email, password: password)
                    }
                    else{
                        observed.signUp(email: email, password: password, confirm: confirmPassword)
                    }
                    routeObserved.appState = .authorized
                } label: {
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25, bottomLeading: 0, bottomTrailing: 25, topTrailing: 0))
                        .foregroundStyle(.blueButton)
                        .frame(height: 60)
                        .overlay(content: {
                            Text( isAuth ? "Увійти" : "Доєднатися")
                                .foregroundStyle(.white)
                        })
                }
                Button{ withAnimation {
                    isAuth.toggle()}
                } label: {
                    Text(isAuth ? "Ще не з нами?" : "Вже є акаунт?").font(.callout)
                        .padding(.top)
                        .foregroundStyle(.black.opacity(0.4))
                    
                }
            }
            .padding(.horizontal, 45)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            LinearGradient(colors: [.purpleTop, .purpleBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        
    }
}


