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
    @StateObject var moviesViewModel = MoviesViewModel()
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let movie = moviesViewModel.movie {
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
        .onAppear(perform: { moviesViewModel.fetchFirebaseMovie(id: entry.movieId) })
        .background(Color.primary.colorInvert()
                        .addBorder(Constants.Colors.shadow, cornerRadius: 10)
                        .shadow(color: Constants.Colors.shadow, radius: 2.5))
    }
    
    
    var posterView: some View {
        ZStack {
            KFImage(URL(string: moviesViewModel.movie?.imageUrl ?? ""))
                .resizable()
                .scaledToFill()
            if showDetail {
                #warning("?")
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
                if let movie = moviesViewModel.movie {
                    HStack(alignment: .top) {
                        Text(movie.genres.joined(separator: ", "))
                            .fontWeight(.bold)
                        Spacer()
                        Text("(\(String(movie.year)))")
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Text("Director: ")
                            .fontWeight(.bold)
                            .underline()
                        Text(movie.director)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Text("Cast: ")
                            .fontWeight(.bold)
                            .underline()
                        Text(movie.actors.joined(separator: ", "))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Text(movie.plot)
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
