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
        ScrollView {
            VStack(alignment: .leading) {
                
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(alignment: .bottom) {
                    Text(networkManager.movie?.genre ?? "...")
                        .font(.subheadline)
                    Spacer()
                    Text("(\(networkManager.movie?.year ?? "..."))")
                        .font(.subheadline)
                }
                
                KFImage(URL(string: self.movie.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    Text("Director: ").fontWeight(.bold)
                    Text(networkManager.movie?.director ?? "...")
                }
                Divider()
                HStack(alignment: .top) {
                    Text("Stars: ").fontWeight(.bold)
                    Text(networkManager.movie?.actors ?? "...")
                }
                Divider()
                Text(networkManager.movie?.plot ?? "...")
            }.onAppear(perform: getMovie)
                .padding()
        }.navigationBarTitle(movie.title)
        
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
