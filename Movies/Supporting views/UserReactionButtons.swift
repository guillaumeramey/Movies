//
//  UserReactionButtons.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct UserReactionButtons: View {
    @EnvironmentObject var movieVM: MovieViewModel
    @EnvironmentObject var entriesViewModel: EntriesViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            if let movieId = movieVM.movie?.id {
                Button(action: {
                    entriesViewModel.react(to: movieId, with: .like)
                }) {
                    ReactionImage(reaction: .like, fill: entriesViewModel.entry?.reaction == .like)
                }
                
                Button(action: {
                    entriesViewModel.react(to: movieId, with: .dislike)
                }) {
                    ReactionImage(reaction: .dislike, fill: entriesViewModel.entry?.reaction == .dislike)
                }
                
                Button(action: {
                    entriesViewModel.react(to: movieId, with: .watchlist)
                }) {
                    ReactionImage(reaction: .watchlist, fill: entriesViewModel.entry?.reaction == .watchlist)
                }
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ReactionImage: View {
    var reaction: UserReaction
    var fill = false
    var loading = false
    var font = Font.title2
    
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
            case .watchlist:
                if fill {
                    Constants.Images.watchlistFill
                        .foregroundColor(Constants.Colors.watchlist)
                }
                Constants.Images.watchlist
                    .foregroundColor(loading ? Color.secondary : Color.primary)
            }
        }
        .font(font)
    }
}
