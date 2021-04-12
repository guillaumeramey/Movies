//
//  SearchMovie.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct SearchMovie: View {
    @Binding var isPresented: Bool
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchString = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(5)
                        .foregroundColor(Color.gray)
                        .opacity(0.6)
                    TextField("search",
                              text: $searchString,
                              onEditingChanged: { changed in
                                isEditing = changed },
                              onCommit: search)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(clearOverlay, alignment: .trailing)
                        .keyboardType(.webSearch)
                }
                .padding()
                
                if networkManager.results.isEmpty {
                    Spacer()
                } else {
                    List(networkManager.results) { movie in
                        NavigationLink(destination: MovieDetail(movie: movie)) {
                            MovieRow(movie: movie)
                        }
                    }
                }
            }
            .navigationBarTitle("Search a movie", displayMode: .inline)
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
        networkManager.search(title: searchString)
    }
}

//struct MovieList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchMovie()
//    }
//}
