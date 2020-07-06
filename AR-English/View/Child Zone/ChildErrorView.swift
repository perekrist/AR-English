//
//  ChildErrorView.swift
//  AR-English
//
//  Created by Кристина Перегудова on 06.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ChildErrorView: View {
    
    @Binding var alert: Bool
    @Binding var error: String
    @Binding var description: String
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text(self.error)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.7))
                
                Text(self.description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding(25)
                
                Button(action: {
                    self.alert.toggle()
                }) {
                    Text("OK")
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
    }
}

struct ChildErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ChildErrorView(alert: .constant(true), error: .constant("incorrect answer!"), description: .constant("Try again or chech the dictionary!"))
    }
}
