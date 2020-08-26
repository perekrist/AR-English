//
//  ParentErrorView.swift
//  AR-English
//
//  Created by Кристина Перегудова on 06.07.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ParentErrorView: View {
    
    @Binding var alert: Bool
    @Binding var error: String
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Error")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.7))
                                
                Text(self.error)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding(25)
                
                Button(action: {
                    self.alert.toggle()
                }) {
                    Text("Cancel")
                        .foregroundColor(Color.black.opacity(0.7))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                }
                .buttonStyle(ButtonModifier())
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.init(UIColor.bg))
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ParentErrorView(alert: .constant(true), error: .constant("an error occu"))
    }
}
