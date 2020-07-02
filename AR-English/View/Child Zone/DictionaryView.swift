//
//  DictionaryView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct DictionaryView: View {
    
    @State private var words: [Word] = [Word(id: 0, name: "Banana", translate: "Банан", image: "banana", priority: "new", descriptin: "", use: ""),
                                        Word(id: 1, name: "Coffee", translate: "Кофе", image: "coffee", priority: "new", descriptin: "", use: ""),
                                        Word(id: 2, name: "Green", translate: "Зеленый", image: "green", priority: "new", descriptin: "", use: ""),
                                        Word(id: 3, name: "Blue", translate: "Синий", image: "blue", priority: "done", descriptin: "", use: ""),
                                        Word(id: 4, name: "Cat", translate: "Кот", image: "cat", priority: "done", descriptin: "", use: ""),
                                        Word(id: 5, name: "Dog", translate: "Собака", image: "dog", priority: "done", descriptin: "", use: "")
    ]
    
    @State private var showWordDescription = false
    @State private var query: String = ""
    
    @State var word: Word = Word(id: 0, name: "Banana", translate: "Банан", image: "banana", priority: "new", descriptin: "", use: "")
    
    var body: some View {
        VStack {
            
            List(words) { word in
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
        }
        .sheet(isPresented: $showWordDescription) {
            WordDescriptionView(word: self.$word)
        }
        
    }
}
