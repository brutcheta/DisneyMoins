//
//  FilmViewModel.swift
//  DisneyMoins
//
//  Created by digital on 05/06/2023.
//

import SwiftUI
import Combine

class FilmViewModel: ObservableObject{
    
    @Published var now_playing_films : Array<FilmLight> = [];
    @Published var popular_films : Array<FilmLight> = [];
    @Published var genres : Array<Genre> = [];
    
    @Published var moviesCategories : Array<FilmLight> = [];
    
    @Published var is_loading :Bool = true;
    
    func loadMovies(type : String) async{
        Task{
            @MainActor in
            is_loading = true
        }
        
        let apiUrl = URL(string: "https://api.themoviedb.org/3/movie/\(type)?api_key=9a8f7a5168ace33d2334ba1fe14a83fb")!
        let session = URLSession.shared
        do {
            let request = URLRequest(url: apiUrl)
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide")
                return;
            }
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Impossible de convertir les données en chaîne JSON")
                return;
            }
            
            print("Réponse valide : \(jsonString)")
            
            let films = try JSONDecoder().decode(FilmsDTO.self, from: data);
            var filmsModel : Array<FilmLight> = [];
            for film in films.results {
                filmsModel.append(FilmLight(filmDto: film))
            }
            
            switch type {
            case "now_playing":
                self.now_playing_films = filmsModel
                
            case "popular" :
                self.popular_films = filmsModel
                print(self.popular_films)
                
            default:
                print("Value does not match any case")
                return
            }
            
            Task{
                @MainActor in
                is_loading = false
            }
            
        } catch {
            print("Erreur : \(error.localizedDescription)")
        }
    }
    
    
    func loadAllGenres() async {
        let apiUrl = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=9a8f7a5168ace33d2334ba1fe14a83fb")!
        let session = URLSession.shared
        do {
            let request = URLRequest(url: apiUrl)
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide")
                return;
            }
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Impossible de convertir les données en chaîne JSON")
                return;
            }
            
            print("Réponse valide : \(jsonString)")
            
            let genres = try JSONDecoder().decode(GenresDTO.self, from: data);
            
            let genresModal = genres.genres.map{genre in
                return Genre(id: genre.id , name: genre.name )
            };
            
            self.genres = genresModal;
            
        } catch {
            print("Erreur : \(error.localizedDescription)")
            return ;
        }
    }
    
    func loadMoviesByCategory(id_category : Int) async{
        Task{
            @MainActor in
            is_loading = true
        }
        
        let apiUrl = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=9a8f7a5168ace33d2334ba1fe14a83fb&sort_by=popularity.desc&with_genres=\(id_category)")!
        let session = URLSession.shared
        do {
            let request = URLRequest(url: apiUrl)
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide")
                return ;
            }
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Impossible de convertir les données en chaîne JSON")
                return ;
            }
            
            print("Réponse valide : \(jsonString)")
            
            let films = try JSONDecoder().decode(FilmsDTO.self, from: data);
            
            let filmsModal = films.results.map{film in
                return FilmLight(filmDto: film)
            };
            
            
            Task{
                @MainActor in
                is_loading = false
            }
            
            self.moviesCategories =  filmsModal;
            
        } catch {
            print("Erreur : \(error.localizedDescription)")
            return ;
        }
    }
    
    
    func loadMovie(id : Int) async -> Film?{
        let apiUrl = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=9a8f7a5168ace33d2334ba1fe14a83fb&append_to_response=videos")!
        let session = URLSession.shared
        do {
            let request = URLRequest(url: apiUrl)
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide")
                return nil;
            }
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Impossible de convertir les données en chaîne JSON")
                return nil;
            }
            
            print("Réponse valide : \(jsonString)")
            
            let film = try JSONDecoder().decode(FilmDTO.self, from: data);
            return Film(filmDto: film);
            
        } catch {
            print("Erreur : \(error.localizedDescription)")
            return nil;
        }
    }
    
}
