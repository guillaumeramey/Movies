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
            if self.localData.userMovies.contains(self.movie) {
                self.localData.userMovies.remove(object: self.movie)
            } else {
                self.localData.userMovies.append(self.movie)
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
