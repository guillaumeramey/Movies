//
//  SearchMovieCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 26/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchMovieCell: View {
    var movie: Search.Result
    @State private var showMovieDetail = false
    @StateObject private var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        HStack {
            KFImage(movie.posterUrl)
                .placeholder { progressView }
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
//            moviesViewModel.testFetchTmdbMovie()
            moviesViewModel.fetchTmdbMovie(id: movie.id)
            showMovieDetail = true
        }
        .sheet(isPresented: $showMovieDetail) {
            MovieView(moviesViewModel: moviesViewModel)
        }
    }
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
    }
}
