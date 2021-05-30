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
    var movieId: String
    @State private var showMovieDetail = false
    @StateObject private var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        HStack {
            if let movie = moviesViewModel.movie {
                KFImage(URL(string: movie.imageUrl))
                    .placeholder { progressView }
                    .resizable()
                    .onTapGesture { showMovieDetail = true }
                    .sheet(isPresented: $showMovieDetail) {
                        MovieView(moviesViewModel: moviesViewModel)
                }
            } else {
                progressView
            }
        }
        .aspectRatio(21/29.7, contentMode: .fill)
        .onAppear { moviesViewModel.fetchFirebaseMovie(id: movieId) }
    }
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
    }
}
