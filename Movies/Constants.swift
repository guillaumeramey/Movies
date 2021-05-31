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
    
    struct Text {
        struct Title {
            static let feed = "Movie Buddies"
            static let myMovies = "My movies"
            static let friends = "Friends"
            static let search = "Search a movie"
        }
        
        struct GenreFilter {
            static let title = "Select a genre"
//            static let likes = "Likes"
//            static let dislikes = "Dislikes"
            static let all = "All"
        }
        
        struct FeedCalendar {
            static let title = "Select a period"
            static let lastWeek = "Last week"
            static let lastMonth = "Last month"
            static let allTimes = "All times"
            
        }
        
        static let searchPlaceholder = "Search"
        static let like = "Like"
        static let dislike = "Dislike"
    }
    
    struct Images {
        struct Tab {
            static let feed = Image(systemName: "house")
            static let search = Image(systemName: "magnifyingglass")
            static let myMovies = Image(systemName: "film")
            static let friends = Image(systemName: "person.3")
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
    }
    
    struct Colors {
        static let shadow = Color(UIColor(named: "ColorShadow") ?? .black)
        static let like = Color.green
        static let dislike = Color.red
        static let watchlist = Color.yellow
    }
}
