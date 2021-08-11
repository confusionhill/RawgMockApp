//
//  TopContent.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 10/08/21.
//

import SwiftUI

struct TopContentView: View {
    @Binding var isSearch:Bool
    @ViewBuilder
    var body: some View {
        VStack{
            HStack {
                VStack(alignment:.leading) {
                    Text("Welcome,")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Text("How is your gaming this week?")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            Spacer()
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Adventure Quest World")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
            }
            .frame(width: UIScreen.width*0.85, height: 60, alignment: .leading)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.bottom)
            .onTapGesture {
                self.isSearch = true
            }
        }.padding(.horizontal)
    }
}
