//
//  StatisticsView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 16.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(days, id: \.self) { i in
                Bar(words: CGFloat(Int.random(in: 0..<7)), day: i)
            }
        }.frame(height: 250)
    }
}

struct Bar: View {
    
    var words: CGFloat = 0
    var day = ""
    
    var body: some View {
        VStack {
            Text("\(Int(words))").foregroundColor(Color.black.opacity(0.5))
            Rectangle().fill(Color.red).frame(width: UIScreen.main.bounds.width / 7 - 15, height: words * 10)
            Text(day).foregroundColor(Color.black.opacity(0.5))
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
