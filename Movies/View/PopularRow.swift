//
//  PopularRow.swift
//  Movies
//
//  Created by Guillaume Ramey on 22/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PopularRow: View {
    var movie: Movie
    var like: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(movie.title)
                    .scaledFont(name: "Lato-Bold", size: 20)
                Spacer()
                LikeButton(movie: movie)
            }
            .padding(.top, 10)
            .padding(.horizontal, 10)
            
            CoverView(movie: movie)
            
            friendsStack
        }
        .listRowBackground(Color.gray.opacity(0.2))
        .background(Color.white)
    }
    
    var friendsStack: some View {
        let friends = FRIENDS.filter { $0.movies.contains(movie) }
        
        return ZStack {
            ForEach(friends.reversed()) { friend in
                KFImage(URL(string: friend.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .clipShape(Circle())
                    .offset(x: CGFloat((friends.firstIndex(of: friend) ?? 0) * 23), y: 0)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
    }
}

struct PopularRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularRow(movie: movieData, like: 3)
    }
}

struct CoverView: View {
    var movie: Movie
    @ObservedObject var networkManager = NetworkManager()
    @State private var showDetail = false
    
    var body: some View {
        ZStack {
            KFImage(URL(string: movie.imageUrl))
                .resizable()
                .scaledToFit()
            
            showDetail ?
                DetailSide(movie: movie).environmentObject(networkManager)
                    .rotation3DEffect(showDetail ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0))) : nil
        }
        .rotation3DEffect(showDetail ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
        .onTapGesture {
            withAnimation {
                self.showDetail.toggle()
            }
        }
    }
}

struct DetailSide: View {
    @ObservedObject var networkManager = NetworkManager()
    var movie: Movie
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
            
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text(networkManager.movie?.genre ?? " ")
                    Spacer()
                    Text("(\(networkManager.movie?.year ?? " "))")
                }
                
                Spacer()
                HStack(alignment: .top) {
                    Text("Director: ")
                        .scaledFont(name: "Lato-Black", size: 20)
                    Text(networkManager.movie?.director ?? " ")
                }
                Spacer()
                HStack(alignment: .top) {
                    Text("Stars: ")
                        .scaledFont(name: "Lato-Black", size: 20)
                    Text(networkManager.movie?.actors ?? " ")
                }
                Spacer()
                Text(networkManager.movie?.plot ?? " ")
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .scaledFont(name: "Lato-Bold", size: 20)
            .colorInvert()
            .onAppear(perform: {
                self.networkManager.getMovie(id: self.movie.id)})
        }
    }
}
