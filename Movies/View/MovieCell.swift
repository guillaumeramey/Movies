//
//  MovieCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 29/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieCell: View {
    var movieId: Int
    @State private var showMovieDetail = false
    @StateObject private var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        HStack {
            if let movie = moviesViewModel.movie {
                KFImage(movie.posterUrl)
                    .placeholder { progressView }
                    .resizable()
                    .onTapGesture { showMovieDetail = true }
            } else {
                progressView
            }
        }
        .aspectRatio(21/29.7, contentMode: .fill)
        .onAppear { moviesViewModel.fetchTmdbMovie(id: movieId) }
        .sheet(isPresented: $showMovieDetail) {
            MovieView(moviesViewModel: moviesViewModel)
        }
    }
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
    }
}
