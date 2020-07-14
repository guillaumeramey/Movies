//
//  ContentView.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var movies = [Movie]()
    @State private var searchString: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Film : ", text: $searchString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    self.loadData()
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
            List(movies, id: \.imdbID) { movie in
                
                AsyncImage(
                    url: URL(string: movie.poster)!,
                    placeholder: Image(systemName: "film")
                )
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height:100)
                
                Text(movie.title)
            }
        }
    }
    
    func loadData() {
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
        ContentView()
    }
}
