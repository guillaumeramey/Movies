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
    var user: Friend
    
    var body: some View {
        List {
            HStack(alignment: .top) {
                KFImage(URL(string: self.user.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                Spacer()
                
                Text(self.user.name)
                    .font(.title)
            }
            .padding()
            
            ForEach(user.movies) { movie in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
        }
        .navigationBarTitle(Text(user.name), displayMode: .inline)
    }
}

struct FriendDetail_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetail(user: FRIENDS[1])
    }
}
