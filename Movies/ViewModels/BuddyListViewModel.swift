//
//  BuddiesViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 25/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class BuddyListViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var buddies = [User]()
    @Published var searchBuddies = [User]()
    
    func fetchBuddies(of user: User?) {
        guard let buddies = user?.buddies else { return }
        let query = db.collection("users").whereField(FieldPath.documentID(), in: buddies)
        query.getDocuments() { querySnapshot, error in
            guard error == nil else {
                print("Error getting buddies:", error?.localizedDescription ?? "")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No buddies found")
                return
            }
            
            DispatchQueue.main.async {
                self.buddies = documents.compactMap {
                    try? $0.data(as: User.self)
                }
            }
        }
    }
    
    func fetchAllBuddies() {
        db.collection("users").getDocuments() { querySnapshot, error in
            guard error == nil else {
                print("Error getting buddies:", error?.localizedDescription ?? "")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No buddies found")
                return
            }
            
            DispatchQueue.main.async {
                self.searchBuddies = documents.compactMap {
                    try? $0.data(as: User.self)
                }
            }
        }
    }
    
    func addBuddy(id: String?) {
        guard let id = id else { return }
        guard let userId = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userId).updateData(["buddies": FieldValue.arrayUnion([id])])
    }
}
