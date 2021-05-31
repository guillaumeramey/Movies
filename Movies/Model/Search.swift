//
//  Search.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 31/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let search = try? newJSONDecoder().decode(Search.self, from: jsonData)

import Foundation

// MARK: - Search
struct Search: Codable {
    let page, totalPages, totalResults: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Result
    struct Result: Codable, Identifiable {
        let id: Int
        let genreIDS: [Int]
        let title, originalLanguage, originalTitle, overview: String
        let popularity, voteAverage: Double
        let voteCount: Int
        private let _releaseDate, _posterPath: String?
        
        var releaseDate: String { String(_releaseDate?.prefix(4) ?? "")}
        var posterUrl: URL? {
            guard let posterPath = _posterPath else { return nil }
            return URL(string: Constants.posterPath + posterPath)
        }
        
        enum CodingKeys: String, CodingKey {
            case genreIDS = "genre_ids"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case _posterPath = "poster_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case _releaseDate = "release_date"
            case id, title
        }
    }
}
