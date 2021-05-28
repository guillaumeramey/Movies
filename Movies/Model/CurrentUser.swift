//
//  CurrentUser.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 27/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation

//class CurrentUser: User {
//    static let shared = CurrentUser()
//
//    private init() { }
//    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
//    
//    @Published var entries = [Entry]() {
//        didSet {
//            likes = entries.filter { $0.reaction == .like }.map { $0.movieId }
//            dislikes = entries.filter { $0.reaction == .dislike }.map { $0.movieId }
//        }
//    }
//    var likesCount: Int = 0
//    var dislikesCount: Int = 0
//    @Published var likes = [String]()
//    @Published var dislikes = [String]()
//}
