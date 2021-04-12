//
//  LikeButton.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct LikeButton: View {
    @EnvironmentObject var localData: LocalData
    var movie: Movie
    
    var body: some View {
        Button(action: {
            if localData.userMovies.contains(movie) {
                localData.userMovies.remove(object: movie)
            } else {
                localData.userMovies.append(movie)
            }
        }) {
            ZStack {
                localData.userMovies.contains(movie) ?
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red) : nil
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
            }
            .font(.title)
        }
        .animation(.default)
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(movie: movieData)
    }
}
