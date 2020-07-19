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
                Text("\(test) movies in common")
            }
        }
        .frame(alignment: .leading)
    }
    
    var test: Int {
        return Set(friend.movies).intersection(Set(MY_MOVIES)).count
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: FRIENDS[1])
    }
}
