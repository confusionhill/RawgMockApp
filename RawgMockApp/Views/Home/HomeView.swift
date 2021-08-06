//
//  HomeView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 04/08/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeVM()
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
                        TierListContent(homeVM: homeVM)
                        //TierListContent(homeVM: homeVM)
                        VStack(alignment:.leading) {
                            Text("Today's Menu")
                                .font(.headline)
                            if homeVM.state == .loading {
                                HStack{
                                    ProgressView()
                                }
                                Divider()
                            }
                            //Viewer
                            ForEach(homeVM.regularPick) { val in
                                NavigationLink(
                                    destination: ItemViewerView(slug: val.slug)
                                        .navigationTitle("Title")
                                        .navigationBarHidden(true),
                                    label: {
                                        SearchListItem(name: val.name ?? "nil", released: val.released ?? "nil", link: val.image ?? "", rating: val.rating ?? 0, rank: val.rank ?? 0)
                                            .foregroundColor(.black)
                                    })
                                Divider()
                            }
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
        .onAppear{
            homeVM.fetchData()
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
    @ObservedObject var homeVM:HomeVM
    @ViewBuilder
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Text("Top Picks")
                    .font(.headline)
                //Image(systemName: "arrow.right")
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators:false ){
                HStack{
                    if homeVM.state == .loading{
                        ForEach(0..<5){_ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 220, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.leading)
                    } else {
                        ForEach(homeVM.topPick[0..<5]) {val in
                            NavigationLink(
                                //MARK: Navigate to Item Viewer
                                destination: ItemViewerView(slug: val.slug ?? "nil")
                                    .navigationTitle("Makan bang")
                                    .navigationBarHidden(true),
                                label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.black)
                                            .frame(width: 220, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .padding(.leading)
                                        RemoteImage(url: val.image ?? "nil")
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 220, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .cornerRadius(20)
                                            .padding(.leading)
                                    }
                                })
                        }
                    }
                    
                }
            }
            .padding(.bottom)
        }
        .background(Color.white)
    }
}

/*
 */
