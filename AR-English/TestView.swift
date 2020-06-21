//
//  DictionaryView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 16.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    @State var test: Test
    @State private var answer: Int = 0
    
    var body: some View {
        VStack {
            Image(test.image)
                .resizable()
                .frame(height: 250)
                .scaledToFit()
            
            Text(test.question)
                .font(.largeTitle)
            
            Picker(selection: $answer, label: EmptyView()) {
                Text(test.first).tag(0)
                Text(test.second).tag(1)
                Text(test.third).tag(2)
            }
        }
    }
}
