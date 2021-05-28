//
//  UserView.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var user: User
    var isFriend = true
    @StateObject var entriesViewModel = EntriesViewModel()
    @State private var showSearchView = false
    @State private var reaction: UserReaction = .like
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                UserImage(image: user.imageUrl, size: .big)
                    .padding(.vertical)
                
                reactionButtons
                
                if entriesViewModel.entries.count > 0 {
                    LazyVGrid(columns: columns, spacing: 2) {
                        let movieIds = entriesViewModel.entries.filter { $0.reaction == reaction }.map { $0.movieId }
                        ForEach(movieIds, id: \.self) { movieId in
                            MovieCell(movieId: movieId)
                        }
                    }
                }
            }
            .navigationBarTitle(user.name, displayMode: .inline)
            .navigationBarItems(trailing: isFriend ? nil : addButton)
        }
        .onAppear(perform: { entriesViewModel.fetchEntries(for: user) })
        .sheet(isPresented: $showSearchView) {
            SearchMovieView(isPresented: $showSearchView)
        }
    }
    
    var addButton: some View {
        Button(action: {
            showSearchView = true
        }) {
            Constants.Images.add
                .foregroundColor(Color.primary)
        }
    }
    
    var reactionButtons: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    reaction = .like
                }) {
                    ReactionImage(reaction: .like, fill: reaction == .like)
                }
                
                Spacer()
                Spacer()
                
                Button(action: {
                    reaction = .dislike
                }) {
                    ReactionImage(reaction: .dislike, fill: reaction == .dislike)
                }
                
                Spacer()
            }
            
            Divider()
                .background(Color.primary)
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
