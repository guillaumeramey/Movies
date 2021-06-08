//
//  EntryListRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct EntryListRow: View {
    var entries: [Entry]
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    @StateObject var movieVM = MovieViewModel()
    @StateObject var userVM = UserViewModel()
    @State private var showUserView = false
    
    var body: some View {
        
        VStack {
            if let user = userVM.user {
                HStack {
                    UserImage(image: user.imageUrl, size: .small)
                    
                    Text(user.name)
                        .fontWeight(.bold)
                        + Text(entries.first?.reaction == .like ? " a aimé " : " n'a pas aimé ")
                    //                    + Text(movieVM.movie?.title ?? "")
                    
                    Spacer()
                }
                .onTapGesture { showUserView = true }
                .sheet(isPresented: $showUserView) {
                    UserView(userVM: userVM)
                }
                
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(entries, id: \.self) { entry in
                        MovieCell(movieId: entry.movieId)
                    }
                }
            }
        }
        .onAppear {
            //            movieVM.fetchMovie(entry.movieId)
            print(entries.map { $0.userId }, entries.map { $0.reaction }, entries.map { $0.movieId })
            guard let userId = entries.first?.userId else { return }
            userVM.fetchUser(userId)
        }
    }
}
