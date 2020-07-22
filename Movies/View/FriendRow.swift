//
//  FriendRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct FriendRow: View {
    @EnvironmentObject var localData: LocalData
    var friend: Friend
    
    var body: some View {
        HStack(spacing: 20) {
            KFImage(URL(string: friend.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(friend.name)
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.bottom, 5)
                Text("\(friend.movies.count) movies")
                    .font(.headline)
                    .fontWeight(.light)
                Text("You have \(commonMovies) movies in common")
            }
        }
        .frame(alignment: .leading)
    }
    
    var commonMovies: Int {
        let friendMovies = Set(friend.movies.map {$0.id})
        let userMovies = Set(localData.userMovies.map {$0.id})
        return friendMovies.intersection(userMovies).count
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: FRIENDS[1])
    }
}
