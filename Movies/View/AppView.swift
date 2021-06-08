//
//  AppView.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var userVM = UserViewModel()
    
    var body: some View {
        TabView {
            EntryListView()
                .tabItem { Constants.Images.Tab.feed }
            
            SearchView()
                .tabItem { Constants.Images.Tab.search}
            
            UserListView()
                .tabItem { Constants.Images.Tab.users }
            
            NavigationView {
                UserView(userVM: userVM)
            }
            .onAppear { userVM.fetchUser() }
            .tabItem { Constants.Images.Tab.currentUser }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
