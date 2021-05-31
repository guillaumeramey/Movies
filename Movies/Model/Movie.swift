//
//  Movie.swift
//  Movies
//
//  Created by Guillaume Ramey on 13/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseFirestore

// MARK: - Search OMDB Response
//struct OmdbResponse: Codable {
//    let search: [OmdbMovie]
//    let totalResults, response: String
//
//    enum CodingKeys: String, CodingKey {
//        case search = "Search"
//        case totalResults
//        case response = "Response"
//    }
//}
//
//struct OmdbMovie: Codable {
//    var id, title, imageUrl: String
//    var year, runtime, genre, director, actors, plot, imdbRating: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "imdbID"
//        case title = "Title"
//        case imageUrl = "Poster"
//        case year = "Year"
//        case runtime = "Runtime"
//        case genre = "Genre"
//        case director = "Director"
//        case actors = "Actors"
//        case plot = "Plot"
//        case imdbRating
//    }
//}

// MARK: - Movie
//struct Movie: Identifiable, Equatable, Hashable, Comparable, Codable {
//    var id: String
//    var title, imageUrl, director, plot, runtime: String
//    var actors, genres: [String]
//    var year: Int
//    var imdbRating: Float
//
//    static func == (lhs:Movie, rhs: Movie) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    static func < (lhs: Movie, rhs: Movie) -> Bool {
//        lhs.title < rhs.title
//    }
//
//    init(from omdbMovie: OmdbMovie) {
//        id = omdbMovie.id
//        title = omdbMovie.title
//        imageUrl = omdbMovie.imageUrl
//        year = Int(omdbMovie.year ?? "") ?? 0
//        runtime = omdbMovie.runtime ?? ""
//        genres = omdbMovie.genre?.components(separatedBy: ", ") ?? []
//        director = omdbMovie.director ?? ""
//        actors = omdbMovie.actors?.components(separatedBy: ", ") ?? []
//        plot = omdbMovie.plot ?? ""
//        imdbRating = Float(omdbMovie.imdbRating ?? "") ?? 0
//    }
//}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? newJSONDecoder().decode(Movie.self, from: jsonData)


// MARK: - Movie
struct Movie: Codable, Identifiable {
    let id: Int
    let runtime: Int?
    let genres: [Genre]
    let originalLanguage, originalTitle, overview: String
    let tagline, title: String
    let imdbID, homepage: String?
    private let _releaseDate, _posterPath: String?
    
    var releaseDate: String { String(_releaseDate?.prefix(4) ?? "")}
    var posterUrl: URL? {
        guard let posterPath = _posterPath else { return nil }
        return URL(string: Constants.posterPath + posterPath)
    }
    

    enum CodingKeys: String, CodingKey {
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case _posterPath = "poster_path"
        case _releaseDate = "release_date"
        case runtime, tagline, title, overview
        case genres, homepage, id
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
