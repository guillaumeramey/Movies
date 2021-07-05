//
//  SearchPersonCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 05/07/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchPersonCell: View {
    var person: SearchPerson.Result
    @State private var showPersonDetail = false
    
    var body: some View {
        HStack {
            KFImage(person.profileUrl)
                .placeholder { LoadingColor() }
                .resizable()
                .frame(width: 100, height: 100 * 29.7 / 21)
            
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .onTapGesture {
            showPersonDetail = true
        }
        .sheet(isPresented: $showPersonDetail) {
            PersonView(person: person)
        }
    }
}
