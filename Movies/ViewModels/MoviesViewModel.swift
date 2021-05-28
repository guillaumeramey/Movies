//
//  MoviesViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseFirestore

private var movieCache = Cache<Movie.ID, Movie>()

class MoviesViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var movieCollection = "movies"
    private let apiURL = "http://omdbapi.com/?"
    private let apiKey = "533d51ab"
    @Published var movie: Movie?
    @Published var searchResults = [Movie]()
    @Published var isLoading = false
    @Published var error: String?
    
    // MARK: - FIREBASE
    func fetchFirebaseMovie(id: String) {
        if let cachedMovie = movieCache[id] {
            self.movie = cachedMovie
            return
        }

        db.collection(movieCollection).document(id).getDocument { documentSnapshot, error in
            guard error == nil else {
                print("Error getting movie:", error?.localizedDescription ?? "")
                self.error = error?.localizedDescription
                return
            }
            
            DispatchQueue.main.async {
                self.movie = try? documentSnapshot?.data(as: Movie.self)
            }
        }
    }
    
    func addMovie() {
        guard let movie = movie else { return }
        let _ = try? db.collection(movieCollection).document(movie.id).setData(from: movie)
    }
    
    // MARK: - OMDB API
    func testSearch() {
        let path = Bundle.main.path(forResource: "MovieSearchData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)

        let decodedResponse = try! JSONDecoder().decode(OmdbResponse.self, from: data)
        DispatchQueue.main.async {
            self.searchResults = decodedResponse.search.map { Movie(from: $0) }
            self.isLoading = false
        }
    }
    
    func search(title: String) {
        let stringURL = apiURL
            + "apikey=\(apiKey)"
            + "&type=movie"
            + "&s=\(title)"
        
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = "no data"
                }
                return
            }
            
//            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
//
//            print(json!)
            
            do {
                let decodedResponse = try JSONDecoder().decode(OmdbResponse.self, from: data)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.searchResults = decodedResponse.search.map { Movie(from: $0) }
                }
            } catch {
                print("Error decoding search response:", error)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = error.localizedDescription
                }
            }
        }
        .resume()
    }
    
    func testFetchOmdbMovie() {
        let path = Bundle.main.path(forResource: "MovieData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)

        let decodedOmdbMovie = try! JSONDecoder().decode(OmdbMovie.self, from: data)
        DispatchQueue.main.async {
            self.movie = Movie(from: decodedOmdbMovie)
            self.isLoading = false
        }
    }
    
    func fetchOmdbMovie(id: String) {
        if let cachedMovie = movieCache[id] {
            self.movie = cachedMovie
            return
        }
        
        let stringURL = apiURL
            + "apikey=\(apiKey)"
            + "&i=\(id)"
        
        guard let url = URL(string: stringURL) else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                self.isLoading = false
                self.error = "no data"
                return
            }
            
//            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
//            
//            print(json!)
            
            do {
                let decodedOmdbMovie = try JSONDecoder().decode(OmdbMovie.self, from: data)
                DispatchQueue.main.async {
                    let movie = Movie(from: decodedOmdbMovie)
                    self.movie = movie
                    movieCache[movie.id] = movie
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
}
