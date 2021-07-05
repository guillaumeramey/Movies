//
//  BuddyRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct BuddyRow: View {
    var buddy: User
    
    var body: some View {
        HStack {
            UserImage(url: buddy.imageURL, size: .medium)
            
            Text(buddy.name ?? "???")
                .font(.title2)
            
            Spacer()
            
//            ReactionImage(reaction: .like, fill: true, font: .callout)
//            Text("\(user.likesCount)")
//            
//            ReactionImage(reaction: .dislike, fill: true, font: .callout)
//            Text("\(user.dislikesCount)")
        }
        .frame(alignment: .leading)
    }
}

//struct FriendRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendRow(user: User(name: "Test", imageUrl: ""))
//    }
//}
