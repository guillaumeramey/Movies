//
//  UserView.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct UserView: View {
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    @State private var reaction: UserReaction = .like
    @StateObject var entryListVM = EntryListViewModel()
    @StateObject var userVM = UserViewModel()
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                if userVM.user != nil {
                    UserImage(image: userVM.user?.imageUrl ?? "", size: .large)
                        .padding(.vertical)
                } else {
                    SignInWithAppleButton { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        switch result {
                        case .success(let user):
                            print("success")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .frame(height: 45)
                    .padding()
                }
                reactionPicker
                
                if let entries = entryListVM.filteredEntries {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(entries, id: \.self) { entry in
                            MovieCell(movieId: entry.movieId)
                        }
                    }
                }
            }
            .navigationBarTitle(userVM.user?.name ?? "", displayMode: .inline)
        }
        .onAppear(perform: {
            entryListVM.fetchUserEntries(userVM.user)
        })
    }
    
    var reactionPicker: some View {
        Picker(selection: $reaction, label: Text("Reaction")) {
            ReactionImage(reaction: .like)
                .tag(UserReaction.like)
            ReactionImage(reaction: .dislike)
                .tag(UserReaction.dislike)
            if userVM.isCurrentUser {
                ReactionImage(reaction: .watchlist)
                    .tag(UserReaction.watchlist)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: reaction, perform: { _ in
            entryListVM.filterEntries(with: reaction)
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
