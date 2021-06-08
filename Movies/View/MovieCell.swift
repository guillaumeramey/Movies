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
    @State private var showMovieView = false
    @StateObject private var movieVM = MovieViewModel()
    
    var body: some View {
        KFImage(movieVM.movie?.posterUrl)
            .placeholder { LoadingColor() }
            .resizable()
            .onTapGesture { showMovieView = true }
            .aspectRatio(21/29.7, contentMode: .fill)
            .onAppear { movieVM.fetchMovie(movieId) }
            .sheet(isPresented: $showMovieView) {
                MovieView(movieVM: movieVM)
            }
    }
}
