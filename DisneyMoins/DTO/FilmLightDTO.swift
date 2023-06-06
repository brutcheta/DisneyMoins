//
//  FilmLightDTO.swift
//  DisneyMoins
//
//  Created by digital on 22/05/2023.
//

import Foundation

struct FilmLightDTO : Decodable
{
    let id : Int
    let original_title : String;
    let overview : String;
    let release_date : String;
    let poster_path :String;
    
    private enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case synopsis = "overview"
            case release_date = "release_date"
            case picture = "poster_path"
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            original_title = try container.decode(String.self, forKey: .title)
            overview = try container.decode(String.self, forKey: .synopsis)
            release_date = try container.decode(String.self, forKey: .release_date)
            poster_path = try container.decode(String.self, forKey: .picture)
        }
}
