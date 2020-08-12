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
                    Spacer()
                    Text("(\(networkManager.movie?.year ?? " "))")
                }
                .font(.subheadline)
                
                KFImage(URL(string: movie.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    Text("Director: ")
                        .fontWeight(.bold)
                    Text(networkManager.movie?.director ?? " ")
                }
                Divider()
                HStack(alignment: .top) {
                    Text("Stars: ")
                        .fontWeight(.bold)
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
        .navigationBarItems(trailing: LikeButton(movie: movie).environmentObject(localData))
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: movieData)
    }
}
