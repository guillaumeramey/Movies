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
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Cookie-Regular", size: 34)!]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    PopularRow(movie: movie, like: movieCounter[movie] ?? 0)
                }
            }
            .navigationBarTitle("Moviegram", displayMode: .inline)
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
