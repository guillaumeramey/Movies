//
//  User.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class User: Identifiable, Equatable, Codable, ObservableObject {
    @DocumentID var id: String?
    var name, imageUrl: String
    var entries: [Entry]?
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init(from queryDocumentSnapshot: QueryDocumentSnapshot) {
        let data = queryDocumentSnapshot.data()
        id = queryDocumentSnapshot.documentID
        name = data["name"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
//        likesCount = data["likes"] as? Int ?? 0
//        dislikesCount = data["dislikes"] as? Int ?? 0
    }
    
//    init(from documentSnapshot: DocumentSnapshot) {
//        let data = documentSnapshot.data()
//        id = documentSnapshot.documentID
//        name = data?["name"] as? String ?? ""
//        imageUrl = data?["imageUrl"] as? String ?? ""
//        likesCount = data?["likes"] as? Int ?? 0
//        dislikesCount = data?["dislikes"] as? Int ?? 0
//    }
    
//    func calculateAffinity(with user: User) -> (rank: Int, title: String, color: Color) {
//        let likes = Set(entries.filter { $0.reaction == .like }.map { $0.movieId })
//        let dislikes = Set(entries.filter { $0.reaction == .dislike }.map { $0.movieId })
//        let userLikes = Set(user.entries.filter { $0.reaction == .like }.map { $0.movieId })
//        let userDislikes = Set(user.entries.filter { $0.reaction == .dislike }.map { $0.movieId })
//
//        let sharedLikes = likes.intersection(userLikes).count
//        let sharedDislikes = dislikes.intersection(userDislikes).count
//        let unshared = likes.intersection(userDislikes).count + dislikes.intersection(userLikes).count
//        let score = sharedLikes + sharedDislikes - unshared
//
//        switch score {
//        case 5...:
//            return (1, "Movie buddies", Color.red)
//        case 2...:
//            return (2, "Good match", Color.orange)
//        case 0...:
//            return (3, "Not so great", Color.yellow)
//        default:
//            return (4, "Incompatibles", Color.blue)
//        }
//    }
    
//    func mostSeenGenre() -> String {
//        let likes = entries.filter { $0.reaction == .like }.compactMap { $0.movie }.compactMap { $0.genres }
//        let dislikes = entries.filter { $0.reaction == .dislike }.compactMap { $0.movie }.compactMap { $0.genres }
//        return (likes + dislikes).mostFrequent() ?? ""
//    }
    
//    func reaction(to movie: Movie) -> UserReaction? {
//        entries.first { $0.movieId == movie.id }?.reaction
//    }
}
