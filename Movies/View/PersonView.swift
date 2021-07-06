//
//  PersonView.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 01/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PersonView: View {
    var person: SearchPerson.Result
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                KFImage(person.profileUrl)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    Text(person.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                )
            }
            .padding()
            
            if let knownFor = person.knownFor {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(knownFor) { movie in
                        MovieCell(movieId: movie.id)
                    }
                }
            }
        }
    }
}
