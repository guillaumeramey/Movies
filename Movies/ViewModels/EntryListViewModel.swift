//
//  EntryListViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 02/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EntryListViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var entryCollection = "entries"
    private var entries = [Entry]()
    @Published var filteredEntries = [Entry]()
    @Published var lastDayEntries = [[Entry]]()
    @Published var lastWeekEntries = [[Entry]]()
    @Published var beforeLastWeekEntries = [[Entry]]()
    
    func fetchEntries() {
        let query = db.collection(entryCollection)
            .order(by: "createdTime", descending: true)
        
        query.getDocuments() { querySnapshot, error in
            guard error == nil else {
                print("Error getting documents:", error?.localizedDescription ?? "")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            do {
                self.entries = try documents.compactMap { try $0.data(as: Entry.self) }
                self.groupEntries()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUserEntries(_ user: User?) {
        guard let userId = user?.id ?? Auth.auth().currentUser?.uid else { return }
        
        db.collection(entryCollection)
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdTime", descending: true)
            .getDocuments() { querySnapshot, error in
                guard error == nil else {
                    print("Error getting entries:", error?.localizedDescription ?? "")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No entry found for user", userId)
                    return
                }
                self.entries = documents.compactMap { try? $0.data(as: Entry.self) }
                self.filterEntries(with: .like)
            }
    }
    
    func filterEntries(with reaction: UserReaction) {
        DispatchQueue.main.async {
            self.filteredEntries = self.entries.filter { $0.reaction == reaction }
        }
    }
    
    func groupEntries() {
        var userIds: Set<String> = Set(entries.map { $0.userId })
        userIds.remove(Auth.auth().currentUser?.uid ?? "")
        
        let lastDay = Timestamp().dateValue().addingTimeInterval(-86400)
        let lastWeek = Timestamp().dateValue().addingTimeInterval(-86400 * 7)
        
        DispatchQueue.main.async {
            userIds.forEach { userId in
                let userLikes = self.entries.filter { $0.userId == userId && $0.reaction == .like }
                let userDislikes = self.entries.filter { $0.userId == userId && $0.reaction == .dislike }
            
                // Last day
                let lastDayLikes = userLikes.filter {
                    guard let createdTime = $0.createdTime?.dateValue() else { return false }
                    return createdTime > lastDay
                }
                if !lastDayLikes.isEmpty {
                    self.lastDayEntries.append(lastDayLikes)
                }
                
                let lastDayDislikes = userDislikes.filter {
                    guard let createdTime = $0.createdTime?.dateValue() else { return false }
                    return createdTime > lastDay
                }
                if !lastDayDislikes.isEmpty {
                    self.lastDayEntries.append(lastDayDislikes)
                }
                
                // Last week
                let lastWeekLikes = userLikes.filter {
                    guard let createdTime = $0.createdTime?.dateValue() else { return false }
                    return createdTime <= lastDay && createdTime > lastWeek
                }
                if !lastWeekLikes.isEmpty {
                    self.lastWeekEntries.append(lastWeekLikes)
                }
                
                let lastWeekDislikes = userDislikes.filter {
                    guard let createdTime = $0.createdTime?.dateValue() else { return false }
                    return createdTime <= lastDay && createdTime > lastWeek
                }
                if !lastWeekDislikes.isEmpty {
                    self.lastWeekEntries.append(lastWeekDislikes)
                }
                
                // Before last week
                let beforeLastWeekLikes = userLikes.filter {
                    guard let createdTime = $0.createdTime?.dateValue() else { return false }
                    return createdTime <= lastWeek
                }
                if !beforeLastWeekLikes.isEmpty {
                    self.beforeLastWeekEntries.append(beforeLastWeekLikes)
                }
                
                let beforeLastWeekDislikes = userDislikes.filter {
                    guard let createdTime = $0.createdTime?.dateValue() else { return false }
                    return createdTime <= lastWeek
                }
                if !beforeLastWeekDislikes.isEmpty {
                    self.beforeLastWeekEntries.append(beforeLastWeekDislikes)
                }
            }
        }
    }
}
