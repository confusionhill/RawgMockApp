//
//  SearchView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var searchVM = SearchVM()
    @State var searchID:String = ""
    @ViewBuilder
    var body: some View {
            ZStack() {
                List {
                    //MARK: Search bar
                    HStack {
                        TextField("search...",text:$searchID)
                            .foregroundColor(.black.opacity(0.7))
                            .padding()
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            .animation(.easeInOut)
                        if searchID != "" {
                            Button(action: {
                                self.searchVM.state = .success
                            }) {
                                Image(systemName: "paperplane.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .animation(.easeInOut)
                            }
                        }
                    }
                    //MARK: List
                    Button("test button"){
                        searchVM.fetchData()
                    }
                    if searchVM.state == .success {
                        Button("loading.."){
                            searchVM.state = .loading
                        }
                    }
                    SearchListView(searchVM: searchVM)
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
