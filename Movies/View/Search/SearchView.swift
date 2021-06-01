//
//  SearchView.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

enum TrendingMediaType: String, Codable {
    case movie, person
}

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    @State private var isEditing = false
    @State private var trendingMediaType: TrendingMediaType = .movie
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        VStack {
            searchTextField
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            trendingPicker
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            if searchVM.searchString.isEmpty {
                if !isEditing {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            if trendingMediaType == .movie {
                                ForEach(searchVM.trendingMovieResults) { movie in
                                    MovieCell(movieId: movie.id)
                                }
                            } else if trendingMediaType == .person {
                                ForEach(searchVM.trendingPersonResults) { person in
                                    PersonCell(person: person)
                                }
                            }
                        }
                    }
                } else {
                    Spacer()
                }
            } else {
                if searchVM.searchMovieResults.isEmpty {
                    List {
                        ForEach(0 ..< 5) { _ in
                            LoadingSearchMovieCell()
                        }
                    }
                } else {
                    List(searchVM.searchMovieResults) { movie in
                        SearchCell(movie: movie)
                    }
                }
            }
        }
        .onAppear(perform: {
            searchVM.fetchTrendingMovies()
            searchVM.fetchTrendingPersons()
        })
    }
    
    var searchTextField: some View {
        HStack {
            Constants.Images.search
                .foregroundColor(Color.primary.opacity(0.5))
            
            ZStack(alignment: .leading) {
                if searchVM.searchString.isEmpty {
                    Text(Constants.Text.searchPlaceholder)
                        .foregroundColor(Color.primary.opacity(0.5))
                }
                TextField("",
                          text: $searchVM.searchString,
                          onEditingChanged: { isEditing = $0 },
                          onCommit: search)
                    .keyboardType(.webSearch)
                    .autocapitalization(.none)
            }
            
            if !searchVM.searchString.isEmpty {
                Button(action: {
                    searchVM.searchString = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.primary.opacity(0.5))
                }
            }
        }
        .frame(height: 35)
        .padding(.horizontal, 5)
        .background(Color.primary.opacity(0.1))
        .cornerRadius(6)
    }
    
    var trendingPicker: some View {
        Picker(selection: $trendingMediaType, label: Text("Media Type")) {
            Image(systemName: "film")
                .tag(TrendingMediaType.movie)
            Image(systemName: "person")
                .tag(TrendingMediaType.person)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    func search() {
        hideKeyboard()
        searchVM.searchMovie()
    }
}
