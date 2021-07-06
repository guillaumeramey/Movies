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
    @StateObject var entryListVM = EntryListViewModel()
    @State private var reaction: UserReaction = .like
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    var buddy = User()
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                UserImage(url: buddy.imageURL, size: .large)
                    .padding(.vertical)
                
                reactionPicker
                
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(entryListVM.filteredEntries, id: \.self) { entry in
                        MovieCell(movieId: entry.mediaId)
                    }
                }
            }
            .navigationBarTitle(buddy.name ?? "", displayMode: .inline)
            .navigationBarItems(trailing: optionsButton)
        }
        .onAppear(perform: {
            entryListVM.fetchUserEntries(buddy)
        })
    }
    
    var optionsButton: some View {
        Button(action: {
            print("Options button pressed...")
        }) {
            Constants.Images.options
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
