//
//  LoadingSearchCell.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 01/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct LoadingSearchMovieCell: View {
    var body: some View {
        HStack {
            LoadingColor()
                .frame(width: 100, height: 100 * 29.7 / 21)
            
            VStack(alignment: .leading) {
                LoadingColor()
                    .frame(height: 25)
                LoadingColor()
                    .frame(height: 25)
            }
        }
    }
}
