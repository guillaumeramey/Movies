//
//  SearchCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 26/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchCell: View {
    var movie: SearchMovie.Result
    @State private var showMovieDetail = false
    @StateObject private var movieVM = MovieViewModel()
    
    var body: some View {
        HStack {
            KFImage(movie.posterUrl)
                .placeholder { LoadingColor() }
                .resizable()
                .frame(width: 100, height: 100 * 29.7 / 21)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(movie.releaseDate)
                    .font(.title3)
            }
        }
        .onTapGesture {
            movieVM.fetchMovie(movie.id)
            showMovieDetail = true
        }
        .sheet(isPresented: $showMovieDetail) {
            MovieView(movieVM: movieVM)
        }
    }
}
