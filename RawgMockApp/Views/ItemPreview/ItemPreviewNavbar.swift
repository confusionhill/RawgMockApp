//
//  ItemPreviewNavbar.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 10/08/21.
//

import SwiftUI

struct NavbarItemViewer: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var itemPreviewVM:ItemPreviewVM
    @Binding var isDrag:Bool
    @ViewBuilder var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .shadow(color:.black.opacity(isDrag ? 0:0.2),radius: 2)
                        )
                }
                Spacer()
                Text(itemPreviewVM.result.name ?? "nil")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .opacity(isDrag ? 1:0)
                    .animation(.easeInOut)
                Spacer()
                Image(systemName: "bookmark.fill")
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(99)
            }
            .padding(.horizontal)
            .offset(y:UIScreen.height*0.07)
            Spacer()
        }
    }
}

