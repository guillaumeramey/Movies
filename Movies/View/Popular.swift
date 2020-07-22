//
//  Popular.swift
//  Movies
//
//  Created by Guillaume Ramey on 21/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct Popular: View {
    @State private var movies = [Movie]()
    @State private var movieCounter = [Movie: Int]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetail(movie: movie)) {
                        PopularRow(movie: movie, like: self.movieCounter[movie] ?? 0)
                    }
                }
            }
            .navigationBarTitle("Popular")
        }
        .onAppear(perform: movieCount)
    }
    
    func movieCount() {
        movieCounter = [Movie: Int]()
        FRIENDS.forEach { friend in
            friend.movies.forEach { movie in
                movieCounter[movie, default: 0] += 1
            }
        }
        movies = movieCounter.sorted(by: {$0.1 > $1.1}).map {$0.0}
    }
}

struct Popular_Previews: PreviewProvider {
    static var previews: some View {
        Popular()
    }
}
