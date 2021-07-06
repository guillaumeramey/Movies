//
//  BuddyListView.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct BuddyListView: View {
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var buddyListVM = BuddyListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(buddyListVM.buddies) { buddy in
                    NavigationLink(destination: BuddyView(buddy: buddy)) {
                        BuddyRow(buddy: buddy)
                    }
                }
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
