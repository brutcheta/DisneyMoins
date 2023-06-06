//
//  GenreView.swift
//  DisneyMoins
//
//  Created by digital on 23/05/2023.
//

import SwiftUI



struct GenreView: View {
    
    @EnvironmentObject var viewModel: FilmViewModel;
    @Environment(\.presentationMode) var presentationMode;
    
    @State var id_category : Int;
    
    init(id_category: Int) {
        self._id_category = State(initialValue: id_category)
    }
    
    
    var body: some View {
        
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
                            if(genre.id == self.id_category){
                                Text(genre.name)
                                    .foregroundColor(.white)
                            }else{
                                Text(genre.name)
                                    .foregroundColor(.white.opacity(0.8))
                                    .onTapGesture {
                                        self.id_category = genre.id
                                        Task{
                                            await viewModel.loadMoviesByCategory(id_category: self.id_category)
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            
            if(viewModel.is_loading){
                Text("Chargement...")
                    .foregroundColor(.white)
                    .padding()
            }
            else{
                ScrollView {
                    if let films = viewModel.moviesCategories{
                        ForEach(films, id: \.self) { film in
                            
                            NavigationLink(destination: ContentView(id: film.id)){
                                HStack{
                                    AsyncImage(url: URL(string: film.picture)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100)
                                            .clipShape(LeftRoundedCorner(radius: 20))
                                            .clipped()
                                            .ignoresSafeArea()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("\(film.title)")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("\(film.release_date)")
                                            .font(.system(size: 17))
                                            .foregroundColor(.white)
                                        
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(film.synopsis)
                                            .font(.system(size: 13))
                                            .lineLimit(3)
                                            .foregroundColor(.white.opacity(0.75))
                                        
                                            .multilineTextAlignment(.leading)
                                        
                                    }
                                    .padding(EdgeInsets.init(top: 10, leading: 5, bottom: 10, trailing: 5))
                                }
                                .frame(maxWidth: .infinity, maxHeight: 350, alignment: .topLeading)
                                .background(Color(red: 0.18, green: 0.28, blue: 0.36, opacity: 1.00).clipShape(RoundedRectangle(cornerRadius:20)))
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color(red: 0.17, green: 0.18, blue: 0.21, opacity: 1.00))
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(Color(red: 0.17, green: 0.18, blue: 0.21, opacity: 1.00))
        .task{
            await viewModel.loadAllGenres();
            await viewModel.loadMoviesByCategory(id_category: self.id_category);
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // Perform your custom back action here
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack{
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                        Text("Retour").foregroundColor(.white)
                    }
                }
            }
        }
    }
}


