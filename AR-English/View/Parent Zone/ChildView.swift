//
//  ChildView.swift
//  AR-English
//
//  Created by Кристина Перегудова on 06.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ChildView: View {
    
    @State var child: Child
    
    var body: some View {
        VStack(spacing: 12) {
            
            if child.sex == "man" {
                Image("child1")
                    .resizable()
                    .frame(width: 80, height: 80)
            } else {
                Image("child2")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            
            Text(child.name)
                .font(.title)
                .padding(.top, 10)
            
            Text("\(2020 - child.birthday) year(s)")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.vertical)
        .frame(width: (UIScreen.main.bounds.width - 60) / 2)
        .background(Color.init(UIColor.bg))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
    }
}
