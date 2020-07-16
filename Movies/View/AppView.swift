//
//  AppView.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            FriendList()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Friends")
                }

            MovieList()
                .tabItem {
                    Image(systemName: "film")
                    Text("Movies")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
