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
        VStack(alignment: .center) {
            Image(word.image)
                .resizable()
                .frame(height: 250)
                .scaledToFit()
            
            HStack {
                Text(word.name)
                    .font(.largeTitle)
                
                Text(" - ")
                    .font(.largeTitle)
                
                Text(word.translate)
                    .font(.largeTitle)
            }
            
            Text("Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. Очень полезня информация для ребенка. ")
                .padding()
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("Посмотреть слово в AR")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding()
        }
    }
}
