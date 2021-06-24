//
//  BuddyListView.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct BuddyListView: View {
    @ObservedObject var buddyListVM = BuddyListViewModel()
    @EnvironmentObject var userVM: UserViewModel
    private var buddyVM = BuddyViewModel()
    
    var body: some View {
//        let affinities = viewModel.users.map { $0.calculateAffinity(with: user) }
//        let ranks = Array(Set(affinities.map { $0.rank })).sorted(by: <)
        
        NavigationView {
            List {
                ForEach(buddyListVM.buddies) { buddy in
                    NavigationLink(destination: BuddyView(buddyVM: buddyVM)) {
                        BuddyRow(buddy: buddy)
                    }
                    .onAppear { buddyVM.buddy = buddy }
                }
                
//                ForEach(ranks, id: \.self) { rank in
//                    let affinity = affinities.first { $0.rank == rank }
//                    Section(header:
//                        HStack {
//                            Constants.Images.affinity
//                                .foregroundColor(affinity?.color)
//                            Text(affinity?.title ?? "")
//                        }
//                        .font(.headline)
//                    ) {
//                        let friends = viewModel.users.filter { $0.calculateAffinity(with: user).rank == rank }
//                        ForEach(friends) { friend in
//                            NavigationLink(destination: UserView(user: friend)) {
//                                FriendRow(user: friend)
//                            }
//                        }
//                    }
//                }
            }
            .navigationBarTitle(Constants.Text.Title.buddies, displayMode: .inline)
        }
        .onAppear() {
            buddyListVM.fetchBuddies(of: userVM.user)
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        BuddyListView()
    }
}
