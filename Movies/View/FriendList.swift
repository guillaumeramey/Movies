//
//  FriendList.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct FriendList: View {

    var body: some View {
        NavigationView {
            List(FRIENDS) { friend in
                NavigationLink(destination: FriendDetail(friend: friend)) {
                    FriendRow(friend: friend)
                }
            }
            .navigationBarTitle("Friends", displayMode: .inline)
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendList()
    }
}
