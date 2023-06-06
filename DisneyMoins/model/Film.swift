//
//  Film.swift
//  DisneyMoins
//
//  Created by digital on 17/04/2023.
//

import Foundation

struct Film {
    
    let title: String;
    
    let sub_title:String;
    
    let release_date:String;
    
    let film_duration:Int;
    
    let categories:[Genre];
    
    let synopsis:String;
    
    let picture: String;
    
    let videos : [Video]
    
    let trailerUrl : String?
    
    init (filmDto : FilmDTO)  {
        self.title = filmDto.original_title;
        self.sub_title = filmDto.tagline;
        self.release_date = filmDto.release_date;
        self.film_duration = filmDto.runtime;
        self.categories = filmDto.genres.map{genre in
            return Genre(id: genre.id , name: genre.name )
        };
        self.synopsis = filmDto.overview;
        self.picture = "https://www.themoviedb.org/t/p/w780"+filmDto.backdrop_path;
        self.videos = filmDto.videos.results.map{video in
            return Video(key: video.key , type: video.type )
        };
        
        let trailers = self.videos.filter { $0.type.lowercased() == "trailer" }
        if let firstTrailer = trailers.first {
                    let trailerKey = firstTrailer.key
                    self.trailerUrl = "https://www.youtube.com/watch?v=\(trailerKey)"
                } else {
                    self.trailerUrl = nil
                }
        
    }
}
