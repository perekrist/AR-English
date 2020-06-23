//
//  LoginView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 11.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State var alert = false
    @State var error = ""
    
    @State var status = false
    
    var body: some View {
        NavigationView {
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
                        
                        Button(action: {
                            self.verify()
                        }) {
                            Text("Login")
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                        }
                        .buttonStyle(ButtonModifier())
                        
                        Text("--OR--")
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 15) {
                            Button(action: {
                                
                            }) {
                                Image("vk")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }.buttonStyle(OthersModifier())
                            
                            Button(action: {
                                
                            }) {
                                Image("google")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }.buttonStyle(OthersModifier())
                        }
                        
                    }.padding(.horizontal, 30)
                }.navigationBarItems(trailing:
                    HStack {
                        Spacer()
                        NavigationLink(destination:
                            RegistrationView()
                        ) {
                            Text("Create account")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                    }
                )
            }
            
            
        }
    }
    
    func verify() {
        UserDefaults.standard.set(true, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
        self.status.toggle()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
