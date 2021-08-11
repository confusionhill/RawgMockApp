//
//  TierList.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 10/08/21.
//

import SwiftUI


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
                                .overlay(ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white)))
                        }
                        .padding(.leading)
                    } else {
                        ForEach(homeVM.topPick) {val in
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

