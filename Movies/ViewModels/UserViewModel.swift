//
//  UserViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 03/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var userCollection = "users"
    var isCurrentUser: Bool {
        user?.id == Auth.auth().currentUser?.uid
    }
    @Published var user: User?
    
    func fetchUser(_ userId: String = Auth.auth().currentUser?.uid ?? "") {
        db.collection("users").document(userId).getDocument { documentSnapshot, error in
            guard error == nil else {
                print("Error getting documents:", error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async {
                self.user = try? documentSnapshot?.data(as: User.self)
            }
        }
    }
    
    //    func likes(of user: User) -> [String] {
    //        user.entries.filter { $0.reaction == .like }.map { $0.movieId }
    //    }
    //
    //    func dislikes(of user: User) -> [String] {
    //        user.entries.filter { $0.reaction == .dislike }.map { $0.movieId }
    //    }
}
