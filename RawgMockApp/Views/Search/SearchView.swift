//
//  SearchView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import SwiftUI

//USEFULL COMPONENT THAT MIGHT BE USED : SearchListView(searchVM: searchVM)

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var searchVM = SearchVM()
    
    @ViewBuilder
    var body: some View {
            ZStack() {
                VStack {
                    //MARK: Search bar
                    SearchBar(text: $searchVM.searchItem, search: searchVM.fetchData)
                        .animation(.easeInOut)
                    List {
                        //MARK: List
                        if searchVM.state == .failure {
                            Text("Item not found")
                        }
                        ForEach(searchVM.data){val in
                            NavigationLink(
                                destination: ItemViewerView(slug: val.slug ?? "nil")
                                    .navigationTitle("memes")
                                    .navigationBarHidden(true),
                                label: {
                                    SearchListItem(name: val.name ?? "Error", released: val.released ?? "Error", link: val.image ?? "Error", rating: val.rating ?? 0, rank: val.rank ?? 0)
                                })
                                .onAppear{
                                    //MARK: PENGEN INFINITE SCROLLING, cuma ngejer deadline (masih bisa submit kan hehehe)
                                    searchVM.isAddingContent(idx: 0)
                                }
                        }
                        if searchVM.state == .loading {
                            ProgressView()
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                }.padding(.top,70)
                
                VStack {
                    Rectangle()
                        .fill(Color.white)
                        .ignoresSafeArea(edges:.top)
                        .frame(height:50)
                        .shadow(radius: 0)
                        .overlay(HStack{
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }.padding())
                    Spacer()
                }
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
