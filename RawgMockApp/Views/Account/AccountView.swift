//
//  AccountView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 06/08/21.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack() {
            Image("dika")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 300)
            Text("Farhandika Zahrir Mufti Guenia")
                .font(.title2)
            Divider()
            Text("Dika is an Undergraduate student at Institut Teknologi Bandung, one of Indonesia's top engineering schools. He also an easy-going person who has an organized attitude, passionate, and creative. Dika developed various skills related to Software Engineering fields such as computer programming, analytical thinking, and teamwork with others. His interests are data analytics, product life cycle, and software engineering. The combination of these skills makes him a unique candidate to be part of a company.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
