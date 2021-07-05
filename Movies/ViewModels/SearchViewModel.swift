//
//  SearchViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 01/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchString = ""
    @Published var searchMovieResults = [SearchMovie.Result]()
    @Published var searchPersonResults = [SearchPerson.Result]()
    @Published var trendingMovieResults = [SearchMovie.Result]()
    @Published var trendingPersonResults = [SearchPerson.Result]()
    @Published var isLoading = false
    @Published var error: String?
    
    // MARK: - TMDB API
    
    func searchMovie() {
        let stringURL = Constants.tmdbUrl
            + "/search/movie"
            + "?api_key=\(Constants.tmdbKey)"
            + "&query=\(searchString.replacingOccurrences(of: " ", with: "+"))"
            + "&language=fr"
            + "&include_adult=false"
        
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedSearch = try JSONDecoder().decode(SearchMovie.self, from: data)
                DispatchQueue.main.async {
                    self.searchMovieResults = decodedSearch.results.filter { $0.posterUrl != nil }
                }
            } catch {
                print("Error decoding search response:", error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        .resume()
    }
    
    func searchPerson() {
        let stringURL = Constants.tmdbUrl
            + "/search/person"
            + "?api_key=\(Constants.tmdbKey)"
            + "&query=\(searchString.replacingOccurrences(of: " ", with: "+"))"
            + "&language=fr"
            + "&include_adult=false"
        
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedSearch = try JSONDecoder().decode(SearchPerson.self, from: data)
                DispatchQueue.main.async {
                    self.searchPersonResults = decodedSearch.results.filter { $0.profileUrl != nil }
                }
            } catch {
                print("Error decoding search response:", error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        .resume()
    }
    
    func fetchTrendingMovies() {
        let stringURL = Constants.tmdbUrl
            + "/trending/movie/day"
            + "?api_key=\(Constants.tmdbKey)"
            + "&language=fr-FR"

        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedSearch = try JSONDecoder().decode(SearchMovie.self, from: data)
                DispatchQueue.main.async {
                    self.trendingMovieResults = decodedSearch.results.filter { $0.posterUrl != nil }
                }
            } catch {
                print("Error decoding trending movies response:", error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        .resume()
    }
    
    func fetchTrendingPersons() {
        let stringURL = Constants.tmdbUrl
            + "/trending/person/day"
            + "?api_key=\(Constants.tmdbKey)"
            + "&language=fr-FR"

        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedSearch = try JSONDecoder().decode(SearchPerson.self, from: data)
                DispatchQueue.main.async {
                    self.trendingPersonResults = decodedSearch.results.filter { $0.profileUrl != nil }
                }
            } catch {
                print("Error decoding trending persons response:", error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        .resume()
    }
}
