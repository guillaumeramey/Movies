//
//  Movie.swift
//  Movies
//
//  Created by Guillaume Ramey on 13/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Movie: Codable, Identifiable {
    let id: Int
    let runtime: Int?
    let genres: [Genre]?
    let originalLanguage, originalTitle, overview: String?
    let tagline, title: String?
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
