//
//  ReactionPicker.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 24/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct ReactionPicker: View {
    @State private var reaction: UserReaction = .like
    
    var body: some View {
        Picker(selection: $reaction, label: Text("Reaction")) {
            ReactionImage(reaction: .like)
                .tag(UserReaction.like)
            ReactionImage(reaction: .dislike)
                .tag(UserReaction.dislike)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: reaction, perform: { _ in
//            entryListVM.filterEntries(with: reaction)
        })
        .onAppear {
//            entryListVM.filterEntries(with: reaction)
        }
    }
}
