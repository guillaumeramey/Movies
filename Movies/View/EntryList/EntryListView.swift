//
//  EntryListView.swift
//  Movies
//
//  Created by Guillaume Ramey on 21/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct EntryListView: View {
    @StateObject var entryListVM = EntryListViewModel()
    @StateObject var userListVM = UserListViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Cookie-Regular", size: 34)!]
    }
    
    var body: some View {
        NavigationView {
            List {
                if !entryListVM.lastDayEntries.isEmpty {
                    Section(header: Text("Last day")) {
                        ForEach(entryListVM.lastDayEntries, id: \.self) { entries in
                            EntryListRow(entries: entries)
                        }
                    }
                }
                if !entryListVM.lastWeekEntries.isEmpty {
                    Section(header: Text("Last week")) {
                        ForEach(entryListVM.lastWeekEntries, id: \.self) { entries in
                            EntryListRow(entries: entries)
                        }
                    }
                }
                if !entryListVM.beforeLastWeekEntries.isEmpty {
                    Section(header: Text("Before last week")) {
                        ForEach(entryListVM.beforeLastWeekEntries, id: \.self) { entries in
                            EntryListRow(entries: entries)
                        }
                    }
                }
            }
            .navigationBarTitle(Constants.Text.Title.entryList, displayMode: .inline)
        }
        .onAppear() {
            entryListVM.fetchEntries()
            userListVM.fetchUsers()
        }
    }
}

struct Popular_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
