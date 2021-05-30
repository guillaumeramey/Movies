//
//  EntriesViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 26/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseFirestore

class EntriesViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var entryCollection = "entries"
    @Published var entries = [Entry]()
    @Published var filteredEntries = [Entry]()
    @Published var entry: Entry?
    
    func fetchEntries() {
        let query = db.collection(entryCollection)
            .order(by: "date", descending: true)
        
        query.getDocuments() { querySnapshot, error in
            guard error == nil else {
                print("Error getting documents:", error?.localizedDescription ?? "")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            DispatchQueue.main.async {
                self.entries = documents.compactMap { try? $0.data(as: Entry.self) }
            }
        }
    }
    
    func fetchEntries(for user: User, filter: UserReaction = .none) {
        guard let userId = user.id else { return }
        db.collection(entryCollection)
            .whereField("userId", isEqualTo: userId)
            .order(by: "date", descending: true)
            .getDocuments() { querySnapshot, error in
                guard error == nil else {
                    print("Error getting entries:", error?.localizedDescription ?? "")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No entry found for user", userId)
                    return
                }
                
                DispatchQueue.main.async {
                    self.entries = documents.compactMap { try? $0.data(as: Entry.self) }
                    self.filterEntries(with: filter)
                }
            }
    }
    
    func addEntry(movieId: String, reaction: UserReaction) {
        guard let userId = currentUser.id else { return }
        entry = Entry(date: Date(), userId: userId, movieId: movieId, reaction: reaction)
        let _ = try? db.collection(entryCollection).document(userId + movieId).setData(from: entry)
    }
    
    func removeEntry() {
        guard let entry = entry else { return }
        db.collection(entryCollection).document(entry.userId + entry.movieId).delete()
        self.entry = nil
    }
    
    func fetchEntry(movieId: String) {
        guard let userId = currentUser.id else { return }
        db.collection(entryCollection).document(userId + movieId).getDocument { documentSnapshot, error in
            guard error == nil else {
                print("Error getting movie:", error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async {
                self.entry = try? documentSnapshot?.data(as: Entry.self)
            }
        }
    }
    
    func filterEntries(with reaction: UserReaction) {
        if reaction == .none {
            filteredEntries = entries
        } else {
            filteredEntries = entries.filter { $0.reaction == reaction }
        }
    }
}
