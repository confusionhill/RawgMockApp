//
//  SearchListView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import Foundation
import SwiftUI

/*
struct SearchListView:View{
    
    @ObservedObject var searchVM:SearchVM
    
    var body:some View {
        switch searchVM.state {
        case .loading:
            ProgressView()
        case .success:
            NavigationLink(
                destination: ItemViewerView()
                    .navigationTitle("Title")
                    .navigationBarHidden(true),
                label: {
                    SearchListItem(name: "", released: "", link: "", rating: 0, rank: 0)
                })
        case .failure :
            Text("Failed")
        }
    }
}
*/

struct SearchListItem:View {
    
    var name:String
    var released:String
    var link:String
    var rating:Double
    var rank:Int
    
    init(name:String,released:String,link:String,rating:Double,rank:Int) {
        self.name = name
        self.released = released
        self.link = link
        self.rank = rank
        self.rating = rating
    }
    
    @ViewBuilder
    var body: some View{
        HStack(alignment:.top){
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                RemoteImage(url: self.link)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
            }
            VStack(alignment:.leading) {
                Text(self.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(self.released)
                    .font(.subheadline)
                    .fontWeight(.light)
                Text("Popularity      : \(self.rank)")
                Text("Rating             : \(String(format: "%.2f", self.rating))") //
            }
            Spacer()
        }
    }
}
