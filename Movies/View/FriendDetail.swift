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
    var friend: Friend
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                KFImage(URL(string: self.friend.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                Spacer()
                
                Text(self.friend.name)
                    .font(.title)
                
            }.padding([.top, .horizontal])
            
            Divider()
            
            List(friend.movies) { movie in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
        }
        .navigationBarTitle(Text(friend.name), displayMode: .inline)
    }
}

struct FriendDetail_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetail(friend: FRIEND_DETAIL)
    }
}
