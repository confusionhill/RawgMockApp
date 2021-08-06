//
//  SearchModel.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 06/08/21.
//

import Foundation

struct search:Codable {
    var next:String
    var results:[result]
}

struct result:Codable,Identifiable {
    var id = UUID()
    var slug:String
    var name:String?
    var released:String?
    var image:String?
    var rating:Float?
    var rank:Int?
    
    enum CodingKeys: String, CodingKey {
        case slug,name,released,rating
        case image = "background_image"
        case rank = "rating_top"
        }
}

