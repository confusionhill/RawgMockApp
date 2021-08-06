//
//  HomeView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 04/08/21.
//

import SwiftUI

struct HomeView: View {
    @State var isSearch:Bool = false
    @ViewBuilder
    var body: some View {
        ZStack {
            Color.black.opacity(0.05).ignoresSafeArea()
            //MARK: TOP THING LA
            ScrollView {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea(edges:.top)
                        .frame(width: UIScreen.width, height: UIScreen.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .position(x: UIScreen.width/2, y:-UIScreen.height*0.2)
                    VStack(spacing:0){
                        //MARK: Top Content
                        Rectangle()
                            .frame(width: UIScreen.width, height: UIScreen.height*0.20)
                            .overlay(
                                TopContentView(isSearch: $isSearch)
                            )
                        //MARK: TOP RANKS
                        TierListContent()
                        TierListContent()
                            .padding(.top)
                        VStack(alignment:.leading) {
                            Text("maka")
                            SearchListItem(name: "lorem", released: "2020", link: "", rating: 0, rank: 0)
                        }
                        .padding()
                        .background(Color.white)
                        .padding(.top)
                        Spacer()
                    }
                }
            }
           // .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
        }
        .fullScreenCover(isPresented: $isSearch, content: {
            NavigationView {
                SearchView()
                    .navigationTitle("Search")
                    .navigationBarHidden(true)
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

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

struct TierListContent: View {
    @ObservedObject var homeVM = HomeVM()
    @ViewBuilder
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Text("Top Picks")
                    .font(.headline)
                Image(systemName: "arrow.right")
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators:false ){
                HStack{
                    NavigationLink(
                        //MARK: Navigate to Item Viewer
                        destination: Text("Makan bang")
                            .navigationTitle("Makan bang")
                            .navigationBarHidden(true),
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black)
                                    .frame(width: 220, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding(.leading)
                                RemoteImage(url: homeVM.link)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 220, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(20)
                                    .padding(.leading)
                            }
                        })
                    ForEach(0..<5){_ in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 220, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .padding(.bottom)
        }
        .background(Color.white)
    }
}
