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

