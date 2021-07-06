//
//  SearchView.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

enum SearchType: String, Codable {
    case movie, person
}

struct SearchView: View {
    @EnvironmentObject var userVM: UserViewModel
    @StateObject private var searchVM = SearchViewModel()
    @State private var isEditing = false
    @State private var searchType: SearchType = .movie
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        VStack {
            searchTextField
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            searchPicker
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            if searchVM.searchString.isEmpty {
                if !isEditing {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            switch searchType {
                            case .movie:
                                ForEach(searchVM.trendingMovieResults) { movie in
                                    MovieCell(movieId: movie.id)
                                }
                            case .person:
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
                resultList
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
                .foregroundColor(Color(.systemGray))
            
            ZStack(alignment: .leading) {
                // manual placeholder to change color
                if searchVM.searchString.isEmpty {
                    switch searchType {
                    case .movie:
                        Text(Constants.Text.Search.moviePlaceholder)
                            .foregroundColor(Color(.systemGray))
                    case .person:
                        Text(Constants.Text.Search.personPlaceholder)
                            .foregroundColor(Color(.systemGray))
                    }
                }
                
                TextField("", text: $searchVM.searchString, onEditingChanged: { isEditing = $0 }, onCommit: search)
                    .keyboardType(.webSearch)
                    .autocapitalization(.none)
            }
            
            if !searchVM.searchString.isEmpty {
                Button(action: {
                    searchVM.searchString = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
        .frame(height: 35)
        .padding(.horizontal, 5)
        .background(Color(.systemGray6))
        .cornerRadius(6)
    }
    
    var searchPicker: some View {
        Picker(selection: $searchType, label: Text("Search type")) {
            Constants.Images.Search.Picker.movie
                .tag(SearchType.movie)
            Constants.Images.Search.Picker.person
                .tag(SearchType.person)
        }
        .onChange(of: searchType) { _ in searchVM.searchString = "" }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var resultList: some View {
        HStack {
            switch searchType {
            case .movie:
                if searchVM.searchMovieResults.isEmpty {
                    List {
                        ForEach(0 ..< 5) { _ in
                            LoadingSearchMovieCell()
                        }
                    }
                } else {
                    List(searchVM.searchMovieResults) { movie in
                        SearchMovieCell(movie: movie)
                    }
                }
            case .person:
                if searchVM.searchPersonResults.isEmpty {
                    List {
                        ForEach(0 ..< 5) { _ in
                            LoadingSearchMovieCell()
                        }
                    }
                } else {
                    List(searchVM.searchPersonResults) { person in
                        SearchPersonCell(person: person)
                    }
                }
            }
        }
    }
    
    func search() {
        hideKeyboard()
        
        switch searchType {
        case .movie:
            searchVM.searchMovie()
        case .person:
            searchVM.searchPerson()
        }
    }
}
