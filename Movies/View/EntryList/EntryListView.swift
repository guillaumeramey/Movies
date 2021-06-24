//
//  EntryListView.swift
//  Movies
//
//  Created by Guillaume Ramey on 21/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var entryListVM = EntryListViewModel()
    @StateObject var buddyListVM = BuddyListViewModel()
    
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
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    .padding(.vertical)
                }
                if !entryListVM.lastWeekEntries.isEmpty {
                    Section(header: Text("Last week")) {
                        ForEach(entryListVM.lastWeekEntries, id: \.self) { entries in
                            EntryListRow(entries: entries)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
                if !entryListVM.beforeLastWeekEntries.isEmpty {
                    Section(header: Text("Before last week")) {
                        ForEach(entryListVM.beforeLastWeekEntries, id: \.self) { entries in
                            EntryListRow(entries: entries)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Constants.Text.Title.entryList, displayMode: .inline)
        }
        .onAppear() {
            entryListVM.fetchEntries()
            buddyListVM.fetchBuddies(of: userVM.user)
        }
    }
}

struct Popular_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
