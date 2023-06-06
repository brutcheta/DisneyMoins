//
//  ListView.swift
//  DisneyMoins
//
//  Created by digital on 22/05/2023.
//

import SwiftUI


struct ListView: View {
    
    @EnvironmentObject var viewModel: FilmViewModel;
    
    
    var body: some View {
        
        
        NavigationView(){
            
            VStack {
                
                HStack{
                    Text("Disney Moins")
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20){
                        if let genres = viewModel.genres{
                            ForEach(genres, id: \.self) {
                                genre in
                                NavigationLink(destination: GenreView(id_category: genre.id)){
                                    Text(genre.name)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
                
                
                ScrollView{
                    
                    VStack(alignment: .leading){
                        
                        Text("Actuellement au cinéma")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        
                        if(viewModel.is_loading){
                            Text("Chargement...")
                                .foregroundColor(.white)
                                .padding()
                        }else{
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    if let films = viewModel.now_playing_films{
                                        ForEach(films, id: \.self) {
                                            film in
                                            NavigationLink(destination: ContentView(id: film.id)){
                                                VStack(){
                                                    ZStack(alignment: .topLeading){
                                                        AsyncImage(url : URL(string:film.picture)){
                                                            phase in
                                                            switch phase {
                                                            case .empty:
                                                                ProgressView()
                                                            case .success(let image):
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .clipped()
                                                            case .failure(let error):
                                                                // Error view when the image fails to load
                                                                Text(error.localizedDescription)
                                                            @unknown default:
                                                                // Fallback view
                                                                Text("Unknown error")
                                                            }
                                                        }
                                                        
                                                        
                                                        Text(film.title)
                                                            .foregroundColor(.white)
                                                            .background(Color.black.opacity(0.2))
                                                            .frame(width : 200)
                                                    }
                                                    .frame(width : 200, height: 300)
                                                    
                                                    
                                                    Text(film.release_date)
                                                        .foregroundColor(.white)
                                                        .frame(width : 200)
                                                        .font(.system(size: 10))
                                                    
                                                    Text(film.synopsis)
                                                        .lineLimit(3)
                                                        .foregroundColor(.white)
                                                        .frame(width : 200)
                                                        .font(.system(size: 13))
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(height: 375)
                        }
                        
                        
                    }
                    .frame(height: 375)
                    .padding(.horizontal)
                    .padding(.top, 40)
                    
                    
                    
                    VStack(alignment: .leading){
                        Text("Les plus populaires")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        
                        if(viewModel.is_loading){
                            Text("Chargement...")
                                .foregroundColor(.white)
                                .padding()
                        }else{
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    if let films = viewModel.popular_films{
                                        ForEach(films, id: \.self) {
                                            film in
                                            NavigationLink(destination: ContentView(id: film.id)){
                                                VStack(){
                                                    ZStack(alignment: .topLeading){
                                                        AsyncImage(url : URL(string:film.picture)){
                                                            phase in
                                                            switch phase {
                                                            case .empty:
                                                                ProgressView()
                                                            case .success(let image):
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .clipped()
                                                            case .failure(let error):
                                                                // Error view when the image fails to load
                                                                Text(error.localizedDescription)
                                                            @unknown default:
                                                                // Fallback view
                                                                Text("Unknown error")
                                                            }
                                                        }
                                                        
                                                        
                                                        Text(film.title)
                                                            .foregroundColor(.white)
                                                            .background(Color.black.opacity(0.2))
                                                            .frame(width : 200)
                                                    }
                                                    .frame(width : 200, height: 300)
                                                    
                                                    
                                                    Text(film.release_date)
                                                        .foregroundColor(.white)
                                                        .frame(width : 200)
                                                        .font(.system(size: 10))
                                                    
                                                    Text(film.synopsis)
                                                        .lineLimit(3)
                                                        .foregroundColor(.white)
                                                        .frame(width : 200)
                                                        .font(.system(size: 13))
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(height: 375)
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal)
                    
                }
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            .background(Color(red: 0.17, green: 0.18, blue: 0.21, opacity: 1.00))
            .task{
                await viewModel.loadAllGenres();
                await viewModel.loadMovies(type: "now_playing");
                await viewModel.loadMovies(type: "popular");
            }
        }
    }
}
