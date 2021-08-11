//
//  ItemViewerView.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 04/08/21.
//


import SwiftUI

struct ItemViewerView: View {
    var slug:String
    
    init(slug:String) {
        self.slug = slug
    }
   @ObservedObject var itemPreviewVM = ItemPreviewVM()
   @State var isDrag:Bool = false
   @ViewBuilder var body: some View {
        ZStack(alignment:.bottom){
            Color.black
            VStack {
                //MARK: Problem, gimana caranya yah?
                if itemPreviewVM.result.image! == ""{
                    ProgressView()
                } else {
                    RemoteImage(url: itemPreviewVM.result.image ?? "ini link klo ga jalan")
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.width, height: UIScreen.height*0.4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }
            //MARK: Scroll View Content
            TheScrollViewContent(isDrag: $isDrag, itemPreviewVM: itemPreviewVM)
            //MARK: Navbar
            Rectangle()
                .fill(Color.white.opacity(isDrag ? 1:0))
                .frame(width: UIScreen.width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(color: .black.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .offset(y:-UIScreen.height*0.90)
                .animation(.easeInOut)
            NavbarItemViewer(itemPreviewVM: self.itemPreviewVM, isDrag: $isDrag)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear{
            itemPreviewVM.fetchData(slug: slug)
        }
    }
}

/*
struct ItemViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ItemViewerView()
    }
}
*/
