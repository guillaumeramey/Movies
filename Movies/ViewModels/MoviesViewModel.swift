//
//  MoviesViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation

private var movieCache = Cache<Movie.ID, Movie>()

class MoviesViewModel: ObservableObject {
    private let apiURL = "https://api.themoviedb.org/3"
    private let apiKey = "b38b9ede5967708ae9e2dc9786ed164d"
    @Published var movie: Movie?
    @Published var searchResults = [Search.Result]()
    @Published var popular = [Search.Result]()
    @Published var isLoading = false
    @Published var error: String?
    
    
    // MARK: - TMDB API
    
    func testFetchTmdbMovie() {
        let path = Bundle.main.path(forResource: "MovieData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        
        DispatchQueue.main.async {
            self.movie = try? JSONDecoder().decode(Movie.self, from: data)
        }
    }
    
    func testSearch() {
        let path = Bundle.main.path(forResource: "SearchData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        let decodedSearch = try! JSONDecoder().decode(Search.self, from: data)
        DispatchQueue.main.async {
            self.searchResults = decodedSearch.results
        }
    }
    
    func search(title: String) {
        let stringURL = apiURL
            + "/search/movie"
            + "?api_key=\(apiKey)"
            + "&query=\(title)"
            + "&language=fr"
        
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedSearch = try JSONDecoder().decode(Search.self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = decodedSearch.results.filter { $0.posterUrl != nil }
                    self.isLoading = false
                }
            } catch {
                print("Error decoding search response:", error)
                self.isLoading = false
            }
        }
        .resume()
    }
    
    func fetchTmdbMovie(id: Int) {
        if let cachedMovie = movieCache[id] {
            self.movie = cachedMovie
            return
        }
        
        let stringURL = apiURL
            + "/movie/\(id)"
            + "?api_key=\(apiKey)"
            + "&language=fr-FR"
                
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
//            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
//
//            print(json!)
            
            do {
                let decodedMovie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self.movie = decodedMovie
                    movieCache[id] = decodedMovie
                    self.isLoading = false
                }
            } catch {
                print("Error decoding movie:", error)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = error.localizedDescription
                }
            }
        }.resume()
    }
    
    func fetchPopular() {
        let stringURL = apiURL
            + "/movie/popular"
            + "?api_key=\(apiKey)"
            + "&language=fr-FR"
        
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedSearch = try JSONDecoder().decode(Search.self, from: data)
                DispatchQueue.main.async {
                    self.popular = decodedSearch.results.filter { $0.posterUrl != nil }
                    self.isLoading = false
                }
            } catch {
                print("Error decoding search response:", error)
                self.isLoading = false
            }
        }
        .resume()
    }
}
