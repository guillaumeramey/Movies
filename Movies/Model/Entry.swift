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
    case like, dislike
}

struct Entry: Codable, Hashable {
    let date: Date
    let movieId: String
    let userId: String
    let reaction: UserReaction
    
//    init(from queryDocumentSnapshot: QueryDocumentSnapshot) {
//        let data = queryDocumentSnapshot.data()
//        date = data["date"] as? Date ?? Date()
//        imdbId = data["movieId"] as? String ?? ""
//        userId = data["userId"] as? String ?? ""
//        switch data["reaction"] as? Int ?? 0 {
//        case 1:
//            self.reaction = .like
//        case 2:
//            self.reaction = .dislike
//        default:
//            self.reaction = .none
//        }
//    }
}
