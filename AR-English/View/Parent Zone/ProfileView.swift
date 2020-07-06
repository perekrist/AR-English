//
//  ProfileView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var index = 0
    @ObservedObject private var realmViewModel = RealmViewModel()
    
    var body: some View {
        ZStack {
            Color.init(UIColor.bg).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Image("parent")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.top, 6)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 8)
                        .background(Color.init(UIColor.bg))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Mom Olga")
                            .font(.title)
                            .foregroundColor(Color.black.opacity(0.8))
                        
                        Text("email@gmail.com")
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    .padding(.leading, 20)
                    
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Button(action: {
                        self.index = 0
                    }) {
                        Text("Children")
                            .foregroundColor(self.index == 0 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 0 ? Color.blue : Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        self.index = 1
                    }) {
                        Text("Charts")
                            .foregroundColor(self.index == 1 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 1 ? Color.blue : Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        self.index = 2
                    }) {
                        Text("Tips")
                            .foregroundColor(self.index == 2 ? Color.white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(self.index == 2 ? Color.blue : Color.clear)
                            .cornerRadius(10)
                    }
                    
                }
                .padding(.horizontal,8)
                .padding(.vertical,5)
                .background(Color.init(UIColor.bg))
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                .padding(.horizontal)
                .padding(.top,25)
                
                
//                if self.index == 0 {
//                    HStack(spacing: 12) {
//                        
//                    }
//                }
                
                if self.index == 1 {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Amelia")
                                .font(.title)
                                .padding(.top, 10)
                            StatisticsView()
                        }
                        .padding()
                        .background(Color.init(UIColor.bg))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                        .padding(.vertical)
                        
                        VStack {
                            Text("Max")
                                .font(.title)
                                .padding(.top, 10)
                            StatisticsView()
                        }
                        .padding()
                        .background(Color.init(UIColor.bg))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                        .padding(.vertical)
                    }
                }
                
                if self.index == 2 {
                    Spacer()
                    Button(action: {
                        self.realmViewModel.removeAll()
                    }) {
                        Text("Remove from db")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    }) {
                        Text("Log OUT")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                if self.index == 0 {
                    Button(action: {
                        
                    }) {
                        
                        Text("Add CHILD")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
