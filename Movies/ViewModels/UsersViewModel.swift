//
//  UsersViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UsersViewModel: ObservableObject {
    var currentUserId = Auth.auth().currentUser?.uid
    private var db = Firestore.firestore()
    @Published var users = [User]() //{
//        didSet {
//            likes = users.flatMap { $0.entries }.filter { $0.reaction == .like }.map { $0.movieId }
//            dislikes = users.flatMap { $0.entries }.filter { $0.reaction == .dislike }.map { $0.movieId }
//        }
//    }
//    @Published var likes = [String]()
//    @Published var dislikes = [String]()
    
    func fetchUsers() {
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("Error getting users:", error?.localizedDescription ?? "")
                return
            }
            
            self.users = querySnapshot?.documents.compactMap { try? $0.data(as: User.self) } ?? []
            
            guard let documents = querySnapshot?.documents else { return }
            self.users = documents.compactMap { queryDocumentSnapshot in
                if queryDocumentSnapshot.documentID == self.currentUserId {
//                    currentUser = User(from: queryDocumentSnapshot)
                    return nil
                }
                return User(from: queryDocumentSnapshot)
            }
        }
    }
    
//    func fetchCurrentUser() {
//        db.collection("users").document(me).addSnapshotListener { documentSnapshot, error in
//            guard let documentSnapshot = documentSnapshot else { return }
//            self.user = User(from: documentSnapshot)
//        }
//    }
    
//    func likes(of user: User) -> [String] {
//        user.entries.filter { $0.reaction == .like }.map { $0.movieId }
//    }
//    
//    func dislikes(of user: User) -> [String] {
//        user.entries.filter { $0.reaction == .dislike }.map { $0.movieId }
//    }
}
