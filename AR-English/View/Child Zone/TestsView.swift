//
//  TestsView.swift
//  AR-English
//
//  Created by Кристина Перегудова on 03.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct TestsView: View {
    
    @ObservedObject private var parseViewModel = ParseViewModel()
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.parseViewModel.tests.count) { i in
                TestView(test: self.parseViewModel.tests[i])
            }
            Spacer()
        }
    }
}

struct TestsView_Previews: PreviewProvider {
    static var previews: some View {
        TestsView()
    }
}
