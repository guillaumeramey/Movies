//
//  FeedView.swift
//  Movies
//
//  Created by Guillaume Ramey on 21/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    @State private var movies = [Movie]() {
        didSet {
            reader?.scrollTo("top", anchor: .top)
        }
    }
//    @State private var reactionCount = [Movie: Int]()
    @State private var showingFilterSheet = false
    @State private var showingCalendarSheet = false
    @State private var reader: ScrollViewProxy?
//    @ObservedObject private var usersViewModel = UsersViewModel()
    @StateObject var entriesViewModel = EntriesViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Cookie-Regular", size: 34)!]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { reader in
                    VStack {
                        ForEach(entriesViewModel.entries, id: \.self) { entry in
                            FeedRow(entry: entry)
                        }
                    }
                    .padding()
                    .id("top")
                    .tag("top")
                    .onAppear {
                        self.reader = reader
                    }
                }
            }
            .navigationBarTitle(Constants.Text.Title.feed, displayMode: .inline)
            .navigationBarItems(trailing: navigationBarItems)
        }
        .onAppear() { entriesViewModel.fetchEntries() }
    }
    
    // MARK: - Feed selection
    
//    private func selectGenre(_ genre: String? = nil) {
//        reactionCount = [Movie: Int]()
//        usersViewModel.users.forEach { user in
//            var movies = [Movie]()
//            if let genre = genre {
//                movies += user.likes.filter { $0.genres?.contains(genre) ?? false }
//                movies += user.dislikes.filter { $0.genres?.contains(genre) ?? false }
//            } else {
//                movies += user.likes
//                movies += user.dislikes
//            }
//            movies.forEach { movie in
//                reactionCount[movie, default: 0] += 1
//            }
//        }
//        movies = reactionCount.sorted(by: {$0.1 > $1.1}).map {$0.0}
//    }
    
    // MARK: - Navigation Bar Items
    
    private var navigationBarItems: some View {
        HStack {
            calendarButton
//            genreFilterButton
        }
    }
    
//    private var genreFilterButton: some View {
//        Button(action: {
//            showingFilterSheet = true
//        }) {
//            Constants.Images.filter
//                .foregroundColor(Color.primary)
//        }
//        .actionSheet(isPresented: $showingFilterSheet) {
//            ActionSheet(
//                title: Text(Constants.Text.GenreFilter.title),
//                message: nil,
//                buttons: genresActionSheetButtons
//            )
//        }
//    }
    
//    private var genresActionSheetButtons: [ActionSheet.Button] {
//        var allGenres = Set<String>()
//        usersViewModel.users.forEach { user in
//            allGenres.formUnion(user.likes.flatMap { $0.genres ?? [] })
//            allGenres.formUnion(user.dislikes.flatMap { $0.genres ?? [] })
//        }
//        
//        var buttons = [ActionSheet.Button]()
//        allGenres.sorted().forEach { genre in
//            buttons.append(.default(Text(genre)) { selectGenre(genre) })
//        }
//        buttons.append(.default(Text(Constants.Text.GenreFilter.all)) { selectGenre() })
//        buttons.append(.cancel())
//        
//        return buttons
//    }
    
    private var calendarButton: some View {
        Button(action: {
            showingCalendarSheet = true
        }) {
            Constants.Images.calendar
                .foregroundColor(Color.primary)
        }
        .actionSheet(isPresented: $showingCalendarSheet) {
            ActionSheet(
                title: Text(Constants.Text.FeedCalendar.title),
                message: nil,
                buttons: [
                    .default(Text(Constants.Text.FeedCalendar.lastWeek)),
                    .default(Text(Constants.Text.FeedCalendar.lastMonth)),
                    .default(Text(Constants.Text.FeedCalendar.allTimes)),
                    .cancel()
                ]
            )
        }
    }
    
}

struct Popular_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
