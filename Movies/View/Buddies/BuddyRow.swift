//
//  BuddyRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct BuddyRow: View {
    var buddy: User
    
    var body: some View {
        HStack {
            UserImage(url: buddy.imageURL, size: .medium)
            
            Text(buddy.name ?? "")
                .font(.title2)
            
            Spacer()
        }
        .frame(alignment: .leading)
    }
}
