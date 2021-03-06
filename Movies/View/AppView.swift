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
            EntryListView()
                .tabItem { Constants.Images.Tab.feed }
            
            SearchView()
                .tabItem { Constants.Images.Tab.search}
            
            BuddyListView()
                .tabItem { Constants.Images.Tab.buddies }
            
            NavigationView {
                UserView()
            }
            .tabItem { Constants.Images.Tab.currentUser }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
