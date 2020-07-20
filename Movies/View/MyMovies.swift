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
    @EnvironmentObject var localData: LocalData
    @State private var presentSearchView = false
    
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
            .navigationBarTitle("My movies")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: self.$presentSearchView) {
            SearchMovie(isPresented: self.$presentSearchView)
                .environmentObject(self.localData)
        }
    }
    
    var addButton: some View {
        Button(action: {
            self.presentSearchView = true
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
