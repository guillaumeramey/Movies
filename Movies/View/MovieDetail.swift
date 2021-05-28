//
//  MovieDetail.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieDetail: View {
    var movie: Movie
    var isSearch = false
    @ObservedObject var moviesViewModel = MoviesViewModel()
    @ObservedObject var entriesViewModel = EntriesViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(movie.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        UserReactionButtons(movieId: movie.id)
                            .environmentObject(entriesViewModel)
                            .environmentObject(moviesViewModel)
                    }
                    
                    Divider()
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(moviesViewModel.movie?.genres.joined(separator: ", ") ?? "")
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
                        Text(moviesViewModel.movie?.director ?? "")
                    }
                    
                    Divider()
                    
                    HStack(alignment: .top) {
                        Text("Cast: ")
                            .fontWeight(.bold)
                        Text(moviesViewModel.movie?.actors.joined(separator: ", ") ?? "")
                    }
                    
                    Divider()
                    
                    Text(moviesViewModel.movie?.plot ?? "")
                }
                .padding()
            }
        }
        .onAppear(perform: {
            if isSearch {
//                moviesViewModel.testFetchOmdbMovie()
                moviesViewModel.fetchOmdbMovie(id: movie.id)
            } else {
                moviesViewModel.fetchFirebaseMovie(id: movie.id)
            }
            entriesViewModel.fetchEntry(movieId: movie.id)
        })
    }
}

//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetail(movie: movieData, isPresented: true)
//    }
//}
