//
//  UserView.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var user: User?
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    @State private var reaction: UserReaction = .none
    @StateObject var entriesViewModel = EntriesViewModel()
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                UserImage(image: user?.imageUrl ?? "", size: .big)
                    .padding(.vertical)
                
                reactionPicker
                
                if let entries = entriesViewModel.filteredEntries {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(entries, id: \.self) { entry in
                            MovieCell(movieId: entry.movieId)
                        }
                    }
                }
            }
            .navigationBarTitle(user?.name ?? "", displayMode: .inline)
        }
        .onAppear(perform: {
            entriesViewModel.fetchUserEntries(for: user, filter: reaction)
        })
    }
    
    var reactionPicker: some View {
        Picker(selection: $reaction, label: Text("Reaction")) {
            Text("All")
                .tag(UserReaction.none)
            ReactionImage(reaction: .like)
                .tag(UserReaction.like)
            ReactionImage(reaction: .dislike)
                .tag(UserReaction.dislike)
            ReactionImage(reaction: .watchlist)
                .tag(UserReaction.watchlist)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: reaction, perform: { _ in
            entriesViewModel.filterEntries(with: reaction)
        })
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User(name: "Moi",
//                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT80oyYRSnMLUxQaqIewIRloV-7L3ppBNlkng&usqp=CAU")
//        UserView(user: user)
//    }
//}
