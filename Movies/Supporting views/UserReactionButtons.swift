//
//  UserReactionButtons.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct UserReactionButtons: View {
    var showText = false
    @EnvironmentObject var moviesViewModel: MoviesViewModel
    @EnvironmentObject var entriesViewModel: EntriesViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                if entriesViewModel.entry?.reaction == .like {
                    entriesViewModel.removeEntry()
                } else {
                    moviesViewModel.addMovie()
                    entriesViewModel.addEntry(movieId: moviesViewModel.movie?.id ?? "", reaction: .like)
                }
            }) {
                ReactionImage(reaction: .like, fill: entriesViewModel.entry?.reaction == .like)
                if showText {
                    Text(Constants.Text.like)
                        .foregroundColor(Color.primary)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Button(action: {
                if entriesViewModel.entry?.reaction == .dislike {
                    entriesViewModel.removeEntry()
                } else {
                    moviesViewModel.addMovie()
                    entriesViewModel.addEntry(movieId: moviesViewModel.movie?.id ?? "", reaction: .dislike)
                }
            }) {
                ReactionImage(reaction: .dislike, fill: entriesViewModel.entry?.reaction == .dislike)
                if showText {
                    Text(Constants.Text.dislike)
                        .foregroundColor(Color.primary)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}


struct ReactionImage: View {
    var reaction: UserReaction
    var fill = false
    var loading = false
    var font = Font.title3
    
    var body: some View {
        ZStack {
            switch reaction {
            case .like:
                if fill {
                    Constants.Images.likeFill
                        .foregroundColor(Constants.Colors.like)
                }
                Constants.Images.like
                    .foregroundColor(loading ? Color.secondary : Color.primary)
            case .dislike:
                if fill {
                    Constants.Images.dislikeFill
                        .foregroundColor(Constants.Colors.dislike)
                }
                Constants.Images.dislike
                    .foregroundColor(loading ? Color.secondary : Color.primary)
            case .none:
                EmptyView()
            }
        }
        .font(font)
    }
}
