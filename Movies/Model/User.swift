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
import FirebaseStorage

class User: Identifiable, Equatable, Codable, ObservableObject {
    @DocumentID var id: String?
    var name, imagePath: String?
    var entries: [Entry]?
    var buddies: [String]?
    var imageURL: URL? {
        guard let imagePath = imagePath else { return nil }
        return URL(string: imagePath)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
//    func fetchUserImage() {
//        guard let id = id else { return }
//        Storage.storage().reference().child("users/\(id).jpg").downloadURL { url, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                self.imageURL = url
//            }
//        }
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
}
