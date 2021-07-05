//
//  Constants.swift
//  Movies
//
//  Created by Guillaume Ramey on 19/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct Constants {
    
    static let posterPath = "https://image.tmdb.org/t/p/original"
    static let tmdbUrl = "https://api.themoviedb.org/3"
    static let tmdbKey = "b38b9ede5967708ae9e2dc9786ed164d"
    
    struct Text {
        struct Title {
            static let entryList = "Movie Buddies"
            static let myMovies = "My movies"
            static let buddies = "Buddies"
            static let search = "Search a movie"
        }
        
//        struct FeedCalendar {
//            static let title = "Select a period"
//            static let lastWeek = "Last week"
//            static let lastMonth = "Last month"
//            static let allTimes = "All times"
//        }
        
        static let searchMoviePlaceholder = "Search movie"
        static let searchPersonPlaceholder = "Search person"
        static let like = "Like"
        static let dislike = "Dislike"
    }
    
    struct Images {
        struct Tab {
            static let feed = Image(systemName: "film")
            static let search = Image(systemName: "magnifyingglass")
            static let buddies = Image(systemName: "person.3")
            static let currentUser = Image(systemName: "person")
        }
        
        static let like = Image(systemName: "hand.thumbsup")
        static let likeFill = Image(systemName: "hand.thumbsup.fill")
        static let dislike = Image(systemName: "hand.thumbsdown")
        static let dislikeFill = Image(systemName: "hand.thumbsdown.fill")
        static let watchlist = Image(systemName: "bookmark")
        static let watchlistFill = Image(systemName: "bookmark.fill")
        static let affinity = Image(systemName: "flame")
        static let filter = Image(systemName: "line.horizontal.3.decrease")
        static let calendar = Image(systemName: "calendar")
        static let add = Image(systemName: "plus.circle")
        static let search = Image(systemName: "magnifyingglass")
        static let edit = Image(systemName: "pencil")
    }
    
    struct Colors {
        static let shadow = Color(UIColor(named: "ColorShadow") ?? .black)
        static let like = Color.green
        static let dislike = Color.red
        static let watchlist = Color.yellow
    }
}
