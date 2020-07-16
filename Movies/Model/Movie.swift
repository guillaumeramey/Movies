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
struct Movie: Codable, Identifiable {
    let id, title, year, poster: String
    let rated, released, website, response: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards, metascore, imdbRating, imdbVotes: String?
    let type, dvd, boxOffice, production: String?
    let ratings: [Rating]?

    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let source, value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
