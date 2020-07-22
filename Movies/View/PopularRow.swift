//
//  PopularRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PopularRow: View {
    var movie: Movie
    var like: Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(movie.title)
                        .font(.headline)
                        .padding(.horizontal, 10)
                    Spacer()
                    Image(systemName: "heart")
                        .padding(.horizontal, 10)
                }
                
                KFImage(URL(string: movie.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                friendsStack
            }
            .frame(alignment: .leading)
        }
        .padding()
        .background(Color.white)
    }
    
    var friendsStack: some View {
        let friends = FRIENDS.filter { $0.movies.contains(movie) }
        
        return ZStack {
            ForEach(friends.reversed()) { friend in
                KFImage(URL(string: friend.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .clipShape(Circle())
                    .offset(x: CGFloat((friends.firstIndex(of: friend) ?? 0) * 25), y: 0)
            }
        }
    }
}

struct PopularRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularRow(movie: movieData, like: 3)
    }
}
