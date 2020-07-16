//
//  MovieList.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct MovieList: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchString: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter text", text: $searchString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.search()
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }.padding([.top, .horizontal])
                
                List(networkManager.results) { movie in
                    NavigationLink(destination: MovieDetail(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
            }.navigationBarTitle("Search", displayMode: .inline)
        }
    }
    
    func search() {
        networkManager.search(title: searchString)
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
