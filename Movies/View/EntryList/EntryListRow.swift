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
    @StateObject var buddyVM = BuddyViewModel()
    @State private var showBuddyView = false
    
    var body: some View {
        VStack {
            if let buddy = buddyVM.buddy {
                HStack {
                    UserImage(url: buddy.imageURL, size: .small)
                    
                    Text(buddy.name ?? "???")
                        .fontWeight(.bold)
                        + Text(entries.first?.reaction == .like ? " a aimé " : " n'a pas aimé ")
                    
                    Spacer()
                }
                .padding(10)
                .onTapGesture { showBuddyView = true }
                .sheet(isPresented: $showBuddyView) {
                    BuddyView(buddyVM: buddyVM)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(entries, id: \.self) { entry in
                            MovieCell(movieId: entry.mediaId)
                        }
                        .frame(height: 200)
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .onAppear {
            guard let userId = entries.first?.userId else { return }
            buddyVM.fetchUser(id: userId)
        }
    }
}
