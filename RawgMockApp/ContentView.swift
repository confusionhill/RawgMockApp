//
//  ContentView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 04/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView{
                HomeView()
                    .navigationTitle("Home")
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
