//
//  Movie.swift
//  Movies
//
//  Created by Guillaume Ramey on 13/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

// MARK: - Search Response
struct Response: Codable {
    let search: [Movie]
    let totalResults, response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Movie
struct Movie: Codable, Identifiable, Equatable, Hashable {
    
    var id, title, imageUrl: String
    var year, runtime, genre, director, actors, plot, imdbRating: String?
    
    static func ==(lhs:Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case imageUrl = "Poster"
        case imdbRating
    }
}
