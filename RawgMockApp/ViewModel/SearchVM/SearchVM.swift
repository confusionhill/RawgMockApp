//
//  SearchVM.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import Foundation
public class SearchVM:ObservableObject {
    
    private enum selection {
        case append,new
    }
    
    @Published var searchItem:String = ""
    @Published var state:DownloadState = .success
    @Published var data = [result]()
    
    private var page:Int = 1
    private var api = Api()
    private let myKey = ApiKey()

    private func setLink() -> URLComponents {
        self.api.link!.path = "/api/games"
        self.api.link!.queryItems = [
            URLQueryItem(name: "key", value: myKey.key),
            URLQueryItem(name: "page", value: String(self.page)),
            URLQueryItem(name: "search", value: self.searchItem),
        ]
        return self.api.link!
    }
    //MARK: Fetch data
    public func fetchData() {
        self.page = 1
        DispatchQueue.main.async {
            self.state = .loading
        }
        let request = URLRequest(url: setLink().url!)
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else {
                self.state = .failure
                return
            }
            //MARK: Fetching the API
            if let error = error {
                print("error! : \(error.localizedDescription)")
                return
            }
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(self.setLink().url!)")
                DispatchQueue.main.async {
                    self.state = .failure
                }
                return
            }
            self.assignData(data: data,error: error,type: .new)
        }
        task.resume()
    }
    
}

//MARK: Appending data when user is scrolling
extension SearchVM {
    
    public func isAddingContent(idx:Int){
        if idx == self.data.endIndex + 3 {
            appendData()
        }
    }
    
    private func appendData() {
        self.page += 1
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
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(self.setLink().url!)")
                return
            }
            self.assignData(data: data,error: error,type: .append)
        }
        task.resume()
    }
}



//Assign Data
extension SearchVM {
    private func assignData(data:Data?,error:Error?,type:selection){
        if let data = data {
            do {
                let hasil = try JSONDecoder().decode(search.self, from: data)
                DispatchQueue.main.async {
                    if type == .new {
                        self.data = hasil.results
                    } else {
                        self.data.append(contentsOf: hasil.results)
                    }
                    self.state = .success
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
