//
//  ItemPreviewVM.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import Foundation

public class ItemPreviewVM:ObservableObject {
    @Published var result = ItemPreviewModel(name: "none", image: "", desc: "none", rating: 0, developers:[developer](),genres: [genre]())
    @Published var devs:[developer] = []
    @Published var genres:[genre] = []
    private var api = Api()
    private let myKey = ApiKey()
    
    private func getAPI(_ slug:String) -> URLComponents {
        self.api.link!.path = "/api/games/\(slug)"
        self.api.link!.queryItems = [
            URLQueryItem(name: "key", value: myKey.key),
        ]
        return api.link!
    }
    
    public func fetchData(slug:String) {
        let request = URLRequest(url: getAPI(slug).url!)
        let task = URLSession.shared.dataTask(with: request) {(data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let hasil = try JSONDecoder().decode(ItemPreviewModel.self, from: data)
                    DispatchQueue.main.async {
                        self.devs = hasil.developers ?? []
                        self.genres = hasil.genres ?? []
                        self.result = hasil
                        //print(self.result)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
