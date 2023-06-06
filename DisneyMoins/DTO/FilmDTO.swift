//
//  FilmDTO.swift
//  DisneyMoins
//
//  Created by digital on 17/04/2023.
//

import Foundation

struct FilmDTO : Decodable
{
    let original_title : String;
    let tagline :String;
    let overview : String;
    let runtime : Int;
    let release_date : String;
    let genres : [GenreDTO];
    let backdrop_path :String;
    let videos : VideosResponse;
    
    private enum CodingKeys: String, CodingKey {
            case title = "original_title"
            case sub_title = "tagline"
            case synopsis = "overview"
            case film_duration = "runtime"
            case release_date = "release_date"
            case categories = "genres"
            case picture = "backdrop_path"
            case videos = "videos"
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            original_title = try container.decode(String.self, forKey: .title)
            tagline = try container.decode(String.self, forKey: .sub_title)
            overview = try container.decode(String.self, forKey: .synopsis)
            runtime = try container.decode(Int.self, forKey: .film_duration)
            release_date = try container.decode(String.self, forKey: .release_date)
            genres = try container.decode([GenreDTO].self, forKey: .categories)
            backdrop_path = try container.decode(String.self, forKey: .picture)
            videos = try container.decode(VideosResponse.self, forKey: .videos)
        }
}
