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
    var movie: Movie
    
    var body: some View {
        HStack {
            KFImage(URL(string: movie.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100 * 4 / 3)
            
            Text(movie.title)
                .font(.headline)
                .fontWeight(.regular)
        }
        .frame(alignment: .leading)
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: movieData)
    }
}
