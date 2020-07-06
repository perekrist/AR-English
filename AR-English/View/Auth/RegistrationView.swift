//
//  LoginView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 11.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var rePassword = ""
    
    @State var alert = false
    @State var error = ""
    
    @ObservedObject private var networkViewModel = NetworkViewModel()
    
    var body: some View {
        ZStack {
            ZStack {
                Color.init(UIColor.bg).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 25) {
                    
                    Text("AR ENGLISH")
                        .foregroundColor(.gray)
                        .font(.title)
                    
                    VStack(spacing: 18) {
                        Image("logo")
                            .resizable()
                            .frame(height: 200)
                    }
                    .padding(20)
                    .modifier(TopModifier())
                    .padding(.bottom, 20)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                        
                        TextField("UserName", text: self.$name)
                    }
                    .modifier(TextModifier())
                    
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                    }
                    .modifier(TextModifier())
                    
                    HStack(spacing: 15) {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        
                        SecureField("Password", text: self.$password)
                    }
                    .modifier(TextModifier())
                    
                    HStack(spacing: 15) {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        
                        SecureField("RePassword", text: self.$rePassword)
                    }
                    .modifier(TextModifier())
                    
                    Button(action: {
                        self.register()
                    }) {
                        Text("Registration")
                            .foregroundColor(Color.black.opacity(0.7))
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                    }
                    .buttonStyle(ButtonModifier())
                    
                }.padding(.horizontal, 30)
            }
            
            if self.alert {
                ParentErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func register() {
        if self.email != "" || self.password != "" || self.rePassword != "" {
            if self.password == self.rePassword {
                self.networkViewModel.register(email: self.email, password: self.password)
            } else {
                self.error = "Type same password and repassword!"
                self.alert.toggle()
            }
        } else {
            self.error = "Fields must be not enpty!"
            self.alert.toggle()
        }
        
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
