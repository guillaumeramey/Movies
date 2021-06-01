//
//  MovieViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation

private var movieCache = Cache<Movie.ID, Movie>()

class MovieViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: String?
    
    // MARK: - TMDB API
    
    func fetchMovie(id: Int) {
        if let cachedMovie = movieCache[id] {
            self.movie = cachedMovie
            return
        }
        
        let stringURL = Constants.tmdbUrl
            + "/movie/\(id)"
            + "?api_key=\(Constants.tmdbKey)"
            + "&language=fr-FR"
                
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedMovie = try JSONDecoder().decode(Movie.self, from: data)
                movieCache[id] = decodedMovie
                DispatchQueue.main.async {
                    self.movie = decodedMovie
                }
            } catch {
                print("Error decoding movie:", error)
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }
}
