//
//  MovieRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieRow: View {
    var movie: Movie!
    
    var body: some View {
        
        HStack {
            KFImage(URL(string: movie.poster))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
            
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text(movie.title)
                        .font(.headline)
                    Text("(\(movie.year))")
                        .font(.headline)
                        .fontWeight(.light)
                }
                Text(movie.genre ?? "")
                    .font(.subheadline)
            }
        }
    }
    
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: movieData)
    }
}
