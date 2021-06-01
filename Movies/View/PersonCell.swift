//
//  PersonCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 01/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PersonCell: View {
    var person: SearchPerson.Result
    @State private var showPersonDetail = false
    
    var body: some View {
        HStack {
            KFImage(person.profileUrl)
                    .placeholder { LoadingColor() }
                    .resizable()
                    .onTapGesture { showPersonDetail = true }
        }
        .aspectRatio(21/29.7, contentMode: .fill)
        .sheet(isPresented: $showPersonDetail) {
            PersonView(person: person)
        }
    }
}
