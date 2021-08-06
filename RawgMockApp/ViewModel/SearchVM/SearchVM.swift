//
//  SearchVM.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import Foundation
public class SearchVM:ObservableObject {
    @Published var searchItem:String = ""
    @Published var state:DownloadState = .loading
    @Published var data = []
    private var api = Api()
    private let myKey = ApiKey()

    private func setLink() -> URLComponents {
        self.api.link!.path = "/api/games"
        self.api.link!.queryItems = [
            URLQueryItem(name: "key", value: myKey.key),
            URLQueryItem(name: "search", value: self.searchItem),
        ]
        return self.api.link!
    }
    
    public func fetchData() {
        DispatchQueue.main.async {
            self.state = .loading
        }
        let request = URLRequest(url: setLink().url!)
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            //MARK: Fetching the API
            if let error = error {
                print("error! : \(error.localizedDescription)")
                return
            }
            if let data = data {
                guard response.statusCode == 200 else {
                    print("ERROR: \(data), Http Status: \(response.statusCode) link: \(self.setLink().url!)")
                    DispatchQueue.main.async {
                        self.state = .failure
                    }
                    return
                }
                print("DATA: \(data)")
                DispatchQueue.main.async {
                    self.state = .success
                }
            }
        }
        task.resume()
    }
    
}

