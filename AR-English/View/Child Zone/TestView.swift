//
//  DictionaryView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 16.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TestView: View {
    
    @State var test: Test
    @State private var selected = ""
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: test.image))
                .resizable()
                .frame(height: 250)
                .scaledToFit()
            
            Text(test.question)
                .font(.largeTitle)
            
            
            ForEach(0 ..< self.test.answers.count) { i in
                Button(action: {
                    self.selected = self.test.answers[i]
                }) {
                    HStack {
                        ZStack {
                            Circle().fill(self.selected == self.test.answers[i] ? Color.blue : Color.black.opacity(0.2)).frame(width: 18, height: 18)
                            if self.selected == self.test.answers[i] {
                                Circle().stroke(Color.blue.opacity(0.5), lineWidth: 4).frame(width: 25, height: 25)
                            }
                        }
                        Spacer()
                        Text(self.test.answers[i])
                            .font(.title)
                        Spacer()
                    }.foregroundColor(.black)
                }.padding()
            }
            
        }
    }
}
