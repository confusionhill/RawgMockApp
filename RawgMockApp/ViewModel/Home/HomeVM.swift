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
    
    @Published public var link:String = "https://media.rawg.io/media/screenshots/999/9996d2692128d717880d2be9f9351765.jpg"
    @Published public var topPick = ""
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
                return "-name"
            case .added:
                return "added"
            case .rating:
                return "rating"
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
        getNewest()
        getByName()
    }
}

//MARK: Fetching Top picks
extension HomeVM {
    private func getTopPicks(){
        let myurl = getAPI(type: .rating).url!
        let request = URLRequest(url: myurl )
        let task = URLSession.shared.dataTask(with: request) {(data,response,error) in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                print("Http Status: \(response.statusCode) link: \(myurl)")
                return
            }
            //Assign Data
            self.assignData(data: data, error: error)
        }
        task.resume()
    }
}

//MARK: Fetching Newest picks
extension HomeVM {
    private func getNewest(){
       // let request = URLRequest(url: getAPI(type: .added).url!)
    }
}

//MARK: Fetching data by name from A-Z
extension HomeVM {
    private func getByName(){
       // let request = URLRequest(url: getAPI(type: .name).url!)
    }
}


//Assign Data
extension HomeVM {
    private func assignData(data:Data?,error:Error?){
        if let data = data {
            do {
                //Queueu
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
