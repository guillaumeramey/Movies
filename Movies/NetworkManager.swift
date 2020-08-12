//
//  NetworkManager.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

private var movieCache = Cache<Movie.ID, Movie>()

class NetworkManager: ObservableObject {
    @Published var results = [Movie]()
    @Published var movie: Movie!
    
    private let apiURL = "http://omdbapi.com/?"
    private let apiKey = "533d51ab"
    
    func search(title: String) {
        
        let stringURL = apiURL
            + "apikey=\(apiKey)"
            + "&type=movie"
            + "&s=\(title)"
        
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.results = decodedResponse.search
                }
                return
            }
        }.resume()
    }
    
    func getMovie(id: String) {
        
        if let cachedMovie = movieCache[id] {
            self.movie = cachedMovie
            return
        }
        
        let stringURL = apiURL
            + "apikey=\(apiKey)"
            + "&i=\(id)"
        
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            if let decodedResponse = try? JSONDecoder().decode(Movie.self, from: data) {
                DispatchQueue.main.async {
                    self.movie = decodedResponse
                    movieCache[self.movie.id] = self.movie
                }
                return
            }
        }.resume()
    }
}
