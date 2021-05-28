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
    @State private var showMovieDetail = false
    var movie: Movie
    
    var body: some View {
        HStack {
            KFImage(URL(string: movie.imageUrl))
                .resizable()
                .frame(width: 100, height: 100 * 29.7 / 21)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(String(movie.year))
                    .font(.title3)
            }
        }
        .onTapGesture { showMovieDetail = true }
        .sheet(isPresented: $showMovieDetail) {
            MovieDetail(movie: movie, isSearch: true)
        }
    }
}
