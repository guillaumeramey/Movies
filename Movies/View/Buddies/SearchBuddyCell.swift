//
//  SearchBuddyCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 06/07/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchBuddyCell: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var showBuddyDetail = false
    var buddy: User
    var buddyListVM = BuddyListViewModel()
    
    var body: some View {
        HStack {
            HStack {
                UserImage(url: buddy.imageURL)
                
                VStack(alignment: .leading) {
                    Text(buddy.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .onTapGesture {
                showBuddyDetail = true
            }
            
            Text((userVM.user?.buddies?.contains(buddy.id!))! ? "T" : "F")
            
            Button("Add") {
                buddyListVM.addBuddy(id: buddy.id)
                buddyListVM.fetchBuddies(of: userVM.user)
            }
        }
        .sheet(isPresented: $showBuddyDetail) {
            BuddyView(buddy: buddy)
        }
    }
}
