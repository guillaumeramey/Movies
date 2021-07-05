//
//  MovieView.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieView: View {
    @StateObject var movieVM: MovieViewModel
    @StateObject var entriesViewModel = EntryViewModel()
    
    var body: some View {
        ScrollView {
            if let movie = movieVM.movie {
                VStack(alignment: .leading) {
                    Text(movie.title ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 2)
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(movie.releaseDate)
                            .font(.title3)
                            .fontWeight(.thin)
                        
                        if let runtime = movie.runtime {
                            Spacer()
                            
                            Text(String(runtime) + " mn")
                                .font(.title3)
                                .fontWeight(.thin)
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(movie.genres?.map { $0.name } ?? [], id: \.self) { genre in
                                Text(genre)
                                    .padding(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.primary, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.leading, 1)
                    }
                    .frame(height: 34)
                    
                    KFImage(movie.posterUrl)
                        .resizable()
                        .scaledToFit()
                    
                    UserReactionButtons()
                        .environmentObject(entriesViewModel)
                        .environmentObject(movieVM)
                    
                    Text(movie.overview ?? "")
                }
                .padding()
            }
        }
        .onAppear(perform: {
            guard let movieId = movieVM.movie?.id else { return }
            entriesViewModel.fetchEntry(movieId: movieId)
        })
    }
}

//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView(movie: movieData, isPresented: true)
//    }
//}
