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
            FeedView()
                .tabItem { Constants.Images.Tab.feed }
            
            FriendListView()
                .tabItem { Constants.Images.Tab.friends }
            
            NavigationView {
                UserView(user: currentUser)
            }
            .tabItem { Constants.Images.Tab.myMovies }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
