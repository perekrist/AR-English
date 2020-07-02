//
//  WordDescriptionView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct WordDescriptionView: View {
    
    @Binding var word: Word
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image(word.image)
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
                        
                    }) {
                        Image(systemName: "speaker.3.fill")
                            .font(.largeTitle)
                            .padding()
                    }
                }
                
                Text("   Банан - жёлтый съедобный фрукт, растущий в джунглях и тропиках")
                    .padding()
                
                Text("   Monkeys like to eat bananas - Обезьяны любят есть бананы\n   Bananas are my favorite fruits - Бананы - это мои любимые фрукты\n   Bananas are yellow - Бананы жёлтого цвета")
                    .padding()
                
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
            }.navigationBarTitle(word.translate)
        }
    }
}
