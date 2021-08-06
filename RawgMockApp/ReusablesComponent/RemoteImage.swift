//
//  RemoteImage.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 04/08/21.
//

import Foundation
import SwiftUI
import Combine

struct RemoteImage:View {
    //MARK: Image State
    private enum State{
        case loading,success,failure
    }
    //MARK: Loader
    private class Loader:ObservableObject{
        var data = Data()
        var state:State = .loading
        
        init(url:String) {
            self.fetchImage(url)
        }
        
        func fetchImage(_ url:String){
            //print("ini url, kenapa ga jalan ? :\(url)")
            guard let url = URL(string: url) else {
                self.state = .failure
                print("\(url) is invalid lah brow, kenapa yak???")
                return
            }
            let session = URLSession.shared
            let request = session.dataTask(with: url){(data,_,error) in
                if let error = error{
                    self.state = .failure
                    print("url : \(url)")
                    print("error bgtszzz : \(error)")
                    return
                }
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }
                //MARK: YOU NEED TO LOAD THE DATA FIRST BEFORE LOADING THE GOD DAMN SHIT, but god knows how
                // my codes are pure shit :)
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
            request.resume()
        }
    }
    
    @StateObject private var loader:Loader
    var loading: AnyView
    var failure: Image
    
    init(url: String, failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = AnyView(ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white)))
        self.failure = failure
    }
    
    //MARK: Func that load an image remotely
    private func loadImage() -> AnyView {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return AnyView(failure)
        default:
            guard let image = UIImage(data: loader.data) else {
                return AnyView(failure)
            }
            return AnyView(Image(uiImage: image).resizable())
        }
    }
    
    @ViewBuilder var body: some View{
        self.loadImage()
    }
}


