//
//  MainView.swift
//  AR-English
//
//  Created by Дарья Перевертайло on 17.06.2020.
//  Copyright © 2020 Дарья Перевертайло. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    DictionaryView()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Dictionary")
                    }
                    LocationsView()
                        .tabItem {
                            Image(systemName: "location")
                            Text("Locations")
                    }
                    GamesView()
                        .tabItem {
                            Image(systemName: "gamecontroller")
                            Text("Games")
                    }
                    TestsView()
                        .tabItem {
                            Image(systemName: "square.and.pencil")
                            Text("Tests")
                    }
                }
            }
            .navigationBarItems(trailing:
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person")
                }.padding()
            )
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
