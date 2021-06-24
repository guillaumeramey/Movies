//
//  EntryViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 26/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EntryViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var entry: Entry?
    
    func react(to mediaId: Int, with reaction: UserReaction) {
        if entry?.reaction == reaction {
            deleteEntry()
        } else {
            addEntry(mediaId: mediaId, reaction: reaction)
        }
    }
    
    func addEntry(mediaId: Int, reaction: UserReaction) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        entry = Entry(userId: userId, mediaId: mediaId, reaction: reaction)
        let _ = try? db.collection("users").document(userId).collection("entries").document(userId + String(mediaId)).setData(from: entry)
    }
    
    func deleteEntry() {
        guard let userId = Auth.auth().currentUser?.uid, let entry = entry else { return }
        db.collection("users").document(userId).collection("entries").document(userId + String(entry.mediaId)).delete()
        self.entry = nil
    }
    
    func fetchEntry(movieId: Int) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let query = db.collection("users").document(userId).collection("entries").document(userId + String(movieId))
        query.getDocument { documentSnapshot, error in
            guard error == nil else {
                print("Error getting media:", error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async {
                self.entry = try? documentSnapshot?.data(as: Entry.self)
            }
        }
    }
}
