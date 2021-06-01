//
//  SearchPerson.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 01/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation

struct SearchPerson: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Result
    struct Result: Codable, Identifiable {
        let id: Int
        let knownFor: [KnownFor]
        let name: String
        
        private let _profilePath: String?
        
        var profileUrl: URL? {
            guard let profilePath = _profilePath else { return nil }
            return URL(string: Constants.posterPath + profilePath)
        }
        
        enum CodingKeys: String, CodingKey {
            case _profilePath = "profile_path"
            case knownFor = "known_for"
            case id, name
        }
    }
    
    // MARK: - KnownFor
    struct KnownFor: Codable, Identifiable {
        let id: Int
        let originalTitle, posterPath: String
        let releaseDate: String
        let genreIDS: [Int]
        let title: String
        let overview: String
        
        enum CodingKeys: String, CodingKey {
            case originalTitle = "original_title"
            case posterPath = "poster_path"
            case id
            case releaseDate = "release_date"
            case genreIDS = "genre_ids"
            case title
            case overview
        }
    }
}
