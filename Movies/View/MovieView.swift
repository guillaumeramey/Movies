//
//  MovieView.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieView: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    @ObservedObject var entriesViewModel = EntriesViewModel()
    
    var body: some View {
        ZStack {
            if let movie = moviesViewModel.movie {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(movie.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            Spacer()
                            
                            UserReactionButtons()
                                .environmentObject(entriesViewModel)
                                .environmentObject(moviesViewModel)
                        }
                        
                        Divider()
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text(movie.genres.joined(separator: ", "))
                            Spacer()
                            Text(String(movie.year))
                        }
                        .font(.subheadline)
                        
                        KFImage(URL(string: movie.imageUrl))
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom)
                        
                        HStack(alignment: .top) {
                            Text("Director: ")
                                .fontWeight(.bold)
                            Text(movie.director)
                        }
                        
                        Divider()
                        
                        HStack(alignment: .top) {
                            Text("Cast: ")
                                .fontWeight(.bold)
                            Text(movie.actors.joined(separator: ", "))
                        }
                        
                        Divider()
                        
                        Text(movie.plot)
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: {
            guard let movieId = moviesViewModel.movie?.id else { return }
            entriesViewModel.fetchEntry(movieId: movieId)
        })
    }
}

//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView(movie: movieData, isPresented: true)
//    }
//}
