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
        guard let myURL = setLink().url else {
            DispatchQueue.main.async {
                self.state = .failure
                self.data = []
            }
            return
        }
        //jalan
        let request = URLRequest(url: myURL)
        //jalan
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else {
                //ga masuk sini
                DispatchQueue.main.async {
                    self.data = []
                    self.state = .failure
                }
                return
            }
            //MARK: Fetching the API
            if let error = error {
                //ga masuk sini
                print("error! : \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.data = []
                    self.state = .failure
                }
                return
            }
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(myURL)")
                DispatchQueue.main.async {
                    self.data = []
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
        print("loading data....")
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            print("loading data....")
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
                let theResult = try JSONDecoder().decode(search.self, from: data)
                DispatchQueue.main.async {
                        self.data = theResult.results
                        print("data :  \(self.data)")
                    self.state = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.data = []
                    self.state = .failure
                }
                print("error! : \(error.localizedDescription)")
            }
        }
    }
}


