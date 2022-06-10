//
//  LocationsView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct LocationsView: View {
    
    @State private var locations: [String] = ["breakfast", "bathroom", "clothes"]
    @State var isVisionPresented = false
    
    var body: some View {
            List(locations, id: \.self) { location in
                Button(action: {
                    if location == "breakfast" {
                        self.isVisionPresented.toggle()
                    }
                }) {
                        Image(location)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .padding()
                            .background(Color.init(self.generateRandomColor()).opacity(0.5))
                            .cornerRadius(20)
                }
            }
            .sheet(isPresented: self.$isVisionPresented) {
                VisionViewController()
            }
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
