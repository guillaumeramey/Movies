//
//  BuddyView.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct BuddyView: View {
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    var buddyVM = BuddyViewModel()
    @State private var reaction: UserReaction = .like
    @StateObject var entryListVM = EntryListViewModel()
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                UserImage(image: buddyVM.buddy?.imageUrl ?? "", size: .large)
                    .padding(.vertical)
                
                reactionPicker
                
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(entryListVM.filteredEntries, id: \.self) { entry in
                        MovieCell(movieId: entry.mediaId)
                    }
                }
            }
            .navigationBarTitle(buddyVM.buddy?.name ?? "???", displayMode: .inline)
            .navigationBarItems(trailing: editButton)
        }
        .onAppear(perform: {
            entryListVM.fetchUserEntries(buddyVM.buddy)
        })
    }
    
    var editButton: some View {
        Button(action: {
            print("Edit button pressed...")
        }) {
            Constants.Images.edit
        }
    }
    
    var reactionPicker: some View {
        Picker(selection: $reaction, label: Text("Reaction")) {
            ReactionImage(reaction: .like)
                .tag(UserReaction.like)
            ReactionImage(reaction: .dislike)
                .tag(UserReaction.dislike)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: reaction, perform: { _ in
            entryListVM.filterEntries(with: reaction)
        })
        .onAppear {
            entryListVM.filterEntries(with: reaction)
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User(name: "Moi",
//                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT80oyYRSnMLUxQaqIewIRloV-7L3ppBNlkng&usqp=CAU")
//        UserView(user: user)
//    }
//}
