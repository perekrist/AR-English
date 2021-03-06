//
//  WordDescriptionView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI

struct WordDescriptionView: View {
    
    @Binding var word: Word
    let speechService = SpeechService()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    WebImage(url: URL(string: word.image))
                        .resizable()
                        .frame(height: 250)
                        .scaledToFit()
                    
                    HStack {
                        
                        HStack {
                            Text(word.name)
                                .font(.largeTitle)
                            
                            Text(" - ")
                                .font(.largeTitle)
                            
                            Text(word.translate)
                                .font(.largeTitle)
                        }.padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: {
                            self.speechService.say(phrase: self.word.descriptin, language: "ru-RU")
                        }) {
                            Image(systemName: "speaker.3.fill")
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                    
                    
                    Text(word.descriptin)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    ForEach((0 ..< word.use.count)) { i in
                        HStack {
                            Button(action: {
                                self.speechService.say(phrase: self.word.use[i].0, language: "en-US")
                            }) {
                                Text(self.word.use[i].0)
                                    .padding()
                                    .multilineTextAlignment(.center)
                            }.background(Color.gray.opacity(0.3))
                                .cornerRadius(5)
                                .padding()
                            
                            Text(" - ")
                            
                            Button(action: {
                                self.speechService.say(phrase: self.word.use[i].1, language: "ru-RU")
                            }) {
                                Text(self.word.use[i].1)
                                    .padding()
                                    .multilineTextAlignment(.center)
                            }.background(Color.gray.opacity(0.3))
                                .cornerRadius(5)
                                .padding()
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: WordContainer()) {
                        Text("Посмотреть слово в AR")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }.navigationBarTitle(word.translate)
        }
    }
}
