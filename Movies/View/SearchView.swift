//
//  SearchView.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @StateObject var moviesViewModel = MoviesViewModel()
    @State private var searchString = ""
    @State private var isEditing = false
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        VStack {
            
            searchTextField
            
            if moviesViewModel.isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
                    .scaleEffect(x: 2, y: 2, anchor: .center)
                Spacer()
            } else {
                if searchString.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(moviesViewModel.popular) { movie in
                                MovieCell(movieId: movie.id)
                            }
                        }
                    }
                    .padding(.top, 5)
                } else {
                    List(moviesViewModel.searchResults) { movie in
                        SearchMovieCell(movie: movie)
                    }
                }
                
            }
        }
        .onAppear(perform: { moviesViewModel.fetchPopular() })
    }
    
    var searchTextField: some View {
        HStack {
            Constants.Images.search
                .foregroundColor(Color.primary.opacity(0.5))
            
            ZStack(alignment: .leading) {
                if searchString.isEmpty {
                    Text(Constants.Text.searchPlaceholder)
                        .foregroundColor(Color.primary.opacity(0.5))
                }
                TextField("",
                          text: $searchString,
                          onEditingChanged: { changed in
                            isEditing = changed },
                          onCommit: search)
                    .keyboardType(.webSearch)
            }
            
            if !searchString.isEmpty {
                Button(action: {
                    self.searchString = ""
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
        .padding(.horizontal)
    }
    
    func search() {
        hideKeyboard()
        //        moviesViewModel.testSearch()
        moviesViewModel.search(title: searchString)
    }
}
