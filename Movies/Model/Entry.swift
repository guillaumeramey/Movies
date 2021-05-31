//
//  Entry.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum UserReaction: String, Codable {
    case none, like, dislike, watchlist
}

struct Entry: Codable, Hashable {
    @ServerTimestamp var createdTime: Timestamp?
    let userId: String
    let movieId: Int
    let reaction: UserReaction
}
