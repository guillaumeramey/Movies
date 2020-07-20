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
    @EnvironmentObject var localData: LocalData
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                HStack(alignment: .firstTextBaseline) {
                    Text(networkManager.movie?.genre ?? " ")
                        .font(.subheadline)
                    Spacer()
                    Text("(\(networkManager.movie?.year ?? " "))")
                        .font(.subheadline)
                }
                
                KFImage(URL(string: movie.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    Text("Director: ").fontWeight(.bold)
                    Text(networkManager.movie?.director ?? " ")
                }
                Divider()
                HStack(alignment: .top) {
                    Text("Stars: ").fontWeight(.bold)
                    Text(networkManager.movie?.actors ?? " ")
                }
                Divider()
                Text(networkManager.movie?.plot ?? " ")
            }
            .onAppear(perform: {
                self.networkManager.getMovie(id: self.movie.id)
            })
            .padding()
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing: likeButton)
    }
    
    var likeButton: some View {
        Button(action: {
            if self.localData.userMovies.contains(self.movie) {
                self.localData.userMovies.remove(object: self.movie)
            } else {
                self.localData.userMovies.append(self.movie)
            }
        }) {
            Image(systemName: localData.userMovies.contains(movie) ? "heart.fill" : "heart")
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: movieData)
    }
}
