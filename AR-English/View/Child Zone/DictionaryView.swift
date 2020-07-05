//
//  DictionaryView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct DictionaryView: View {
    
    @State private var showWordDescription = false
    @State private var query: String = ""
    
    @State var word: Word = Word(id: 0, name: "Banana", translate: "Банан", image: "banana", priority: "new", descriptin: "", use: [])
    
    @ObservedObject private var realmViewModel = RealmViewModel()
    
    var body: some View {
        VStack {
            if self.realmViewModel.words.count > 0 {
                List(self.realmViewModel.words) { word in
                    HStack {
                        Image(word.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .clipShape(Circle())
                        
                        VStack {
                            Text(word.name)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            Text(word.translate)
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(word.priority)
                            .foregroundColor(word.priority == "done" ? .green : .black)
                            .font(.title)
                        
                        
                        Image(systemName: "chevron.right")
                    }.onTapGesture {
                        self.showWordDescription.toggle()
                        self.word = word
                    }
                }
            } else {
                Text("Find new words in LOCATIONS!")
                    .font(.largeTitle)
            }
        }
        .onAppear {
            self.realmViewModel.getWords()
        }
        .sheet(isPresented: $showWordDescription) {
            WordDescriptionView(word: self.$word)
        }
        
    }
}
