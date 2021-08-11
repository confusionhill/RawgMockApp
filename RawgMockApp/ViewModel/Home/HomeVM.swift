//
//  HomeVM.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import Foundation

public class HomeVM:ObservableObject {
    
    private enum types {
        case name,added,rating
    }
    private var api = Api()
    private let myKey = ApiKey()
    
    let dispatchGroup = DispatchGroup() // pengen make, cuma masih bingung hehehe, biarin dulu aja, buat nanti abis course kelar
    
    @Published  var topPick = [TopAndNew]()
    @Published var regularPick = [BasicHome]()
    @Published var state:DownloadState = .loading
}

extension HomeVM {
    private func run(completion: @escaping() -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
    
    //MARK: getAPI
    private func getAPI(type:types) -> URLComponents {
        self.api.link!.path = "/api/games"
        let tipe:String = {
            switch type{
            case .name:
                return "name"
            case .added:
                return "added"
            case .rating:
                return "-rating"
            }
        }()
        self.api.link!.queryItems = [
            URLQueryItem(name: "key", value: myKey.key),
            URLQueryItem(name: "ordering", value: tipe),
        ]
        return api.link!
    }
    //MARK: FETCH DATA FUNCTION, impementing dispatch group function :)
    public func fetchData() {
        print("Downloading data....")
        getTopPicks()
       // getNewest()
        getByName()
        dispatchGroup.notify(queue: .main){
            self.state = .success
            print("Loading data success..")
        }
    }
}

//MARK: Fetching Top picks
extension HomeVM {
    private func getTopPicks(){
        guard let myurl = getAPI(type: .rating).url else {
            self.run {
                self.state = .failure
            }
            return
        }
        let request = URLRequest(url: myurl )
        dispatchGroup.enter()
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(myurl)")
                return
            }
            //Assign Data
            if let data = data {
                do{
                    let theResult = try JSONDecoder().decode(HomeModelTopAndNew.self, from: data)
                    self.run {
                        self.topPick = theResult.results
                       // print("data: \(self.topPick)")
                        self.dispatchGroup.leave()
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

//MARK: Fetching Newest picks
extension HomeVM {
    private func getNewest(){
        let myurl = getAPI(type: .added).url!
        let request = URLRequest(url: myurl )
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(myurl)")
                return
            }
            //Assign Data
            if let data = data {
                do{
                    let theResult = try JSONDecoder().decode(HomeModelTopAndNew.self, from: data)
                    self.run {
                        self.topPick = theResult.results
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

//MARK: Fetching data by name from A-Z
extension HomeVM {
    private func getByName(){
        guard let myurl = getAPI(type: .name).url else {
            self.run {
                self.state = .failure
            }
            return
        }
        dispatchGroup.enter()
        let request = URLRequest(url: myurl )
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(myurl)")
                return
            }
            if let data = data {
                do{
                    let theResult = try JSONDecoder().decode(HomeModelBasic.self, from: data)
                    self.run {
                        self.regularPick = theResult.results
                        self.dispatchGroup.leave()
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}


