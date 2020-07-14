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
struct Movie: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case game = "game"
    case movie = "movie"
    case series = "series"
}
