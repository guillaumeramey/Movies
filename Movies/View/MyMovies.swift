//
//  MyMovies.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MyMovies: View {
    @State private var presentSearchView = false
    
    var body: some View {
        NavigationView {
            List(MY_MOVIES) { movie in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
            .navigationBarTitle("My movies")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: self.$presentSearchView) {
            SearchMovie(isPresented: self.$presentSearchView)
        }
    }
    
    var addButton: some View {
        Button(action: {
            self.presentSearchView = true
        }) {
            Image(systemName: "plus")
        }
    }
}

struct MyMovies_Previews: PreviewProvider {
    static var previews: some View {
        MyMovies()
    }
}
