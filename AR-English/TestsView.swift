//
//  TestsView.swift
//  P2B
//
//  Created by Кристина Перегудова on 03.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct TestsView: View {
    @State private var tests: [Test] = [Test(id: 0, difficulty: 2, image: "banana", question: "What is this?", first: "Banana", second: "Orange", third: "Apple", answer: 0),
                                        Test(id: 0, difficulty: 2, image: "banana", question: "What is this?", first: "Banana", second: "Orange", third: "Apple", answer: 0),
                                        Test(id: 0, difficulty: 2, image: "banana", question: "What is this?", first: "Banana", second: "Orange", third: "Apple", answer: 0)
    ]
    
    var body: some View {
        VStack {
            List(tests) { test in
                TestView(test: test)
            }
        }
    }
}

struct TestsView_Previews: PreviewProvider {
    static var previews: some View {
        TestsView()
    }
}
