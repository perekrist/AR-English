//
//  GamesView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 13.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct GamesView: View {
    @State private var games: [String] = ["Memo", "Game2", "Game3", "Game4"]
    @State var isMemoViewPresented = false
    
    var body: some View {
            List(games, id: \.self) { game in
                
                Button(action: {
                    if game == "Memo" {
                        self.isMemoViewPresented.toggle()
                    }
                }) {
                  Text(game)
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.width / 2 + 50)
                    .background(Color.init(self.generateRandomColor()).opacity(0.5))
                    .foregroundColor(game == "Memo" ? Color.black : Color.black.opacity(0.3))
                    .cornerRadius(20)
                    
                }
                
                
            }
            .sheet(isPresented: self.$isMemoViewPresented) {
                MemoContainer()
            }
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
