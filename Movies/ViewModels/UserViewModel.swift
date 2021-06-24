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
    @Published var user: User?
    
    func fetchCurrentUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userId).getDocument { documentSnapshot, error in
            guard error == nil else {
                print("Error A fetching current user id: ", userId, "\n", error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    self.user = try documentSnapshot?.data(as: User.self)
                } catch {
                    print("Error B fetching current user id: ", userId, "\n", error.localizedDescription)
                }
            }
        }
    }
}
