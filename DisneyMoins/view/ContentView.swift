//
//  ContentView.swift
//  DisneyMoins
//
//  Created by digital on 04/04/2023.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode;
    @EnvironmentObject var viewModel: FilmViewModel;
    @State var film: Film? = nil;
    
    @State var id : Int
    
    init(id :Int) {
        self._id = State(initialValue: id)
    }
    
    
    var body: some View {
        ScrollView{
            
            VStack {
                if let film = self.film {
                    HStack(alignment: .center){
                        AsyncImage(url : URL(string:film.picture)){
                            phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .scaledToFill()
                                    .frame(height: 400)
                                    .clipped()
                            case .failure(let error):
                                // Error view when the image fails to load
                                Text(error.localizedDescription)
                            @unknown default:
                                // Fallback view
                                Text("Unknown error")
                            }
                        }
                    }
                    .frame(maxHeight: 400)
                    
                    VStack{
                        Text(film.title)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        
                        
                        Text(film.sub_title)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                    
                    ScrollView(.horizontal){
                        HStack(spacing : 20
                        ){
                            ForEach(film.categories, id: \.self) { category in
                                Text(category.name)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.gray, lineWidth: 4)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .scrollIndicators(.hidden)
                    
                    
                    HStack{
                        Text("Durée : \(film.film_duration) min")
                            .foregroundColor(.white)
                        Text("|")
                            .foregroundColor(.white)
                        Text("Date de sortie : \(film.release_date)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    
                    Text(film.synopsis)
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        Button {
                            if let url = film.trailerUrl{
                                UIApplication.shared.open(URL(string : url)!, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Text("Lire la bande annonce")
                                .padding(15)
                        }
                        .contentShape(Rectangle())
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding([.bottom, .horizontal],20)
                    
                }
            }
        }
        .frame(alignment: .top)
        .ignoresSafeArea()
        .background(Color(red: 0.17, green: 0.18, blue: 0.21, opacity: 1.00))
        .task{
            self.film = await viewModel.loadMovie(id: self.id);
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
