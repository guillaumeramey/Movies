//
//  UserListViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserListViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var userCollection = "users"
    @Published var users = [User]() //{
    //        didSet {
    //            likes = users.flatMap { $0.entries }.filter { $0.reaction == .like }.map { $0.movieId }
    //            dislikes = users.flatMap { $0.entries }.filter { $0.reaction == .dislike }.map { $0.movieId }
    //        }
    //    }
    //    @Published var likes = [String]()
    //    @Published var dislikes = [String]()
    
    func fetchUsers() {
        db.collection(userCollection).getDocuments() { querySnapshot, error in
            guard error == nil else {
                print("Error getting documents:", error?.localizedDescription ?? "")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            DispatchQueue.main.async {
                self.users = documents.compactMap {
                    let user = try? $0.data(as: User.self)
                    return user?.id == Auth.auth().currentUser?.uid ? nil : user
                }
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
