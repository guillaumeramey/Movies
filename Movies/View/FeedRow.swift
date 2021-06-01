//
//  FeedRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct FeedRow: View {
    var entry: Entry
    @StateObject var movieVM = MovieViewModel()
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let movie = movieVM.movie {
                HStack {
                    Text(movie.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Reactions(movie: movie)
                }
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                posterView
                
//                UserReactionButtons(movieId: movie.id, showText: true)
//                    .padding(.top, 5)
//                    .padding(.bottom, 10)
//                    .padding(.horizontal, 10)
            } else {
                EmptyView()
            }
        }
        .onAppear(perform: {
            movieVM.fetchMovie(id: entry.movieId)
            
        })
        .background(Color.primary.colorInvert()
                        .addBorder(Constants.Colors.shadow, cornerRadius: 10)
                        .shadow(color: Constants.Colors.shadow, radius: 2.5))
    }
    
    
    var posterView: some View {
        ZStack {
            KFImage(movieVM.movie?.posterUrl)
                .resizable()
                .scaledToFill()
            if showDetail {
                posterBack
                    .rotation3DEffect(showDetail ? Angle(degrees: 180): Angle(degrees: 0),
                                      axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
            }
        }
        .onTapGesture {
            withAnimation { showDetail.toggle() }
        }
        .rotation3DEffect(showDetail ? Angle(degrees: 180): Angle(degrees: 0),
                          axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
    }
    
    var posterBack: some View {
        ZStack {
            Color.black
                .opacity(0.5)
            
            VStack(alignment: .leading) {
                if let movie = movieVM.movie {
                    HStack(alignment: .top) {
                        Text(movie.genres.map { $0.name }.joined(separator: ", "))
                            .fontWeight(.bold)
                        Spacer()
                        Text(movie.releaseDate)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Text(movie.overview)
                        .fontWeight(.bold)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(x: 2, y: 2, anchor: .center)
                }
            }
            .font(.title3)
            .padding()
            .foregroundColor(Color.white)
        }
    }
}
