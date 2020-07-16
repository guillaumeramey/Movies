//
//  MovieDetail.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieDetail: View {
    var movie: Movie
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                    Text("(\(movie.year))")
                        .font(.title)
                        .fontWeight(.light)
                }
                Text(networkManager.movie?.genre ?? "")
                    .font(.subheadline)
            }
            .padding(EdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 12))
            
            KFImage(URL(string: movie.poster))
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text(networkManager.movie?.plot ?? "")
                .font(.body)
                .padding()
            
            Spacer()
        }.onAppear(perform: getMovie)
    }
    
    func getMovie() {
        networkManager.getMovie(id: movie.id)
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: movieData)
    }
}
