//
//  SearchMovieView.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct SearchMovieView: View {
    @Binding var isPresented: Bool
    @StateObject var moviesViewModel = MoviesViewModel()
    @State private var searchString = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Constants.Images.search
                        .padding(5)
                        .foregroundColor(Color.gray)
                        .opacity(0.6)
                    TextField(Constants.Text.searchPlaceholder,
                              text: $searchString,
                              onEditingChanged: { changed in
                                isEditing = changed },
                              onCommit: search)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(clearOverlay, alignment: .trailing)
                        .keyboardType(.webSearch)
                }
                .padding()
                                
                if moviesViewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
                        .scaleEffect(x: 2, y: 2, anchor: .center)
                    Spacer()
                } else {
                    List(moviesViewModel.searchResults) { movie in
                        SearchMovieCell(movie: movie)
                    }
                }
            }
            .navigationBarTitle(Constants.Text.Title.search, displayMode: .inline)
            .navigationBarItems(trailing: doneButton)
        }
    }
    
    var clearOverlay: some View {
        VStack {
            if !searchString.isEmpty {
                Button(action: {
                    self.searchString = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.gray.opacity(0.5))
                        .padding(10)
                }
            }
        }
    }
    
    var doneButton: some View {
        Button("Done") {
            isPresented = false
        }
    }
    
    func search() {
        hideKeyboard()
//        moviesViewModel.testSearch()
        moviesViewModel.search(title: searchString)
    }
}
