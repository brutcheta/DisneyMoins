//
//  FilmLight.swift
//  DisneyMoins
//
//  Created by digital on 22/05/2023.
//

import Foundation


struct FilmLight : Hashable{
    
    let id : Int;
    
    let title: String;
    
    let release_date:String;
    
    let synopsis:String;
    
    let picture: String;
    
    
    init (filmDto : FilmLightDTO)  {
        self.id = filmDto.id;
        self.title = filmDto.original_title;
        self.release_date = String(filmDto.release_date.split(separator: Character("-"))[0]);
        self.synopsis = filmDto.overview;
        self.picture = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2"+filmDto.poster_path;
    }
}
