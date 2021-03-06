//
//  ContentView.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieList: View {
    @State private var movies = [Movie]()
    @State private var searchString: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Film : ", text: $searchString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        self.searchMovie()
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                List(movies, id: \.imdbID) { movie in
                    MovieRow(movie: movie)
                }
            }
            .padding()
            .navigationBarTitle(Text("Search a movie"))
        }
    }
    
    func searchMovie() {
        NetworkManager.shared.searchMovie(title: searchString) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                print(movies)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
