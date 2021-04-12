//
//  FriendDetail.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct FriendDetail: View {
    @EnvironmentObject var localData: LocalData
    var friend: Friend
    
    var body: some View {
        List {
            HStack(alignment: .top) {
                KFImage(URL(string: friend.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                Spacer()
                
                Text(friend.name)
                    .font(.title)
            }
            .padding()
            
            ForEach(friend.movies) { movie in
                if !localData.userMovies.contains(movie) {
                    NavigationLink(destination: MovieDetail(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
            }
            
            Section {
                Text("Movies in common:")
                    .font(.headline)
            }
            
            ForEach(friend.movies) { movie in
                if localData.userMovies.contains(movie) {
                    NavigationLink(destination: MovieDetail(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
            }
            
        }
        .navigationBarTitle(Text(friend.name), displayMode: .inline)
    }
}

struct FriendDetail_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetail(friend: FRIENDS[1])
    }
}
