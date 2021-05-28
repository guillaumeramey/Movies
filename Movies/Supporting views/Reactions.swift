//
//  Reactions.swift
//  Movies
//
//  Created by Guillaume Ramey on 21/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct Reactions: View {
    var movie: Movie
    @ObservedObject var usersViewModel = UsersViewModel()
    
    var body: some View {
        HStack {
            EmptyView()
//            let likes = usersViewModel.likes.count
//            if likes > 0 {
//                ReactionImage(reaction: .like, fill: true, font: .callout)
//                Text("\(likes)")
//            }
//
//            let dislikes = usersViewModel.dislikes.count
//            if dislikes > 0 {
//                ReactionImage(reaction: .dislike, fill: true, font: .callout)
//                Text("\(dislikes)")
//            }
        }
    }
}
