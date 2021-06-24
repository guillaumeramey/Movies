//
//  BuddyViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 03/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class BuddyViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var buddy: User?
    
    func fetchUser(id: String) {
        db.collection("users").document(id).getDocument { documentSnapshot, error in
            guard error == nil else {
                print("Error A fetching user id: ", id, "\n", error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    self.buddy = try documentSnapshot?.data(as: User.self)
                } catch {
                    print("Error B fetching user id: ", id, "\n", error.localizedDescription)
                }
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
