//
//  ItemPreviewModel.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 06/08/21.
//

import Foundation

public struct ItemPreviewModel:Codable {
    var name:String?
    var image:String?
    var desc:String?
    var rating:Float?
    var developers:[developer]?
    var genres:[genre]?
    
    enum CodingKeys: String, CodingKey {
        case name,rating,developers,genres
        case desc = "description_raw"
        case image = "background_image"
    }
    
}

public struct developer:Codable,Identifiable{
    public var id:Int?
    public var name:String?
}

public struct genre:Codable,Identifiable {
    public var id:Int?
    public var name:String?
}
