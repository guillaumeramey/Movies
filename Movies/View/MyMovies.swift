//
//  MyMovies.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct MyMovies: View {
    @EnvironmentObject var localData: LocalData
    @State private var showSearchView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(localData.userMovies) { movie in
                    NavigationLink(destination: MovieDetail(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
                .onDelete(perform: deleteMovie)
            }
            .navigationBarTitle("My movies", displayMode: .inline)
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $showSearchView) {
            SearchMovie(isPresented: $showSearchView)
                .environmentObject(localData)
        }
    }
    
    var addButton: some View {
        Button(action: {
            showSearchView = true
        }) {
            Image(systemName: "plus")
        }
    }
    
    func deleteMovie(at offsets: IndexSet) {
        localData.userMovies.remove(atOffsets: offsets)
    }
}

struct MyMovies_Previews: PreviewProvider {
    static var previews: some View {
        MyMovies()
    }
}
