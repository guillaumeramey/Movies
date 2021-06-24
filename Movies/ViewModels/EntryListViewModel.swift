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
    private var entries = [Entry]()
    @Published var filteredEntries = [Entry]()
    @Published var lastDayEntries = [[Entry]]()
    @Published var lastWeekEntries = [[Entry]]()
    @Published var beforeLastWeekEntries = [[Entry]]()
    
    func fetchEntries() {
        let query = db.collectionGroup("entries")
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
        
        db.collectionGroup("entries")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdTime", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard error == nil else {
                    print("Error fetching entries:", error?.localizedDescription ?? "")
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
        let defaultDate = Date(timeIntervalSince1970: 0)
        
        DispatchQueue.main.async {
            self.lastDayEntries = []
            self.lastWeekEntries = []
            self.beforeLastWeekEntries = []
            
            userIds.forEach { userId in
                let userLikes = self.entries.filter { $0.userId == userId && $0.reaction == .like }
                let userDislikes = self.entries.filter { $0.userId == userId && $0.reaction == .dislike }
                
                // Last day
                let lastDayLikes = userLikes.filter {
                    $0.createdTime?.dateValue() ?? defaultDate > lastDay
                }
                if !lastDayLikes.isEmpty {
                    self.lastDayEntries.append(lastDayLikes)
                }
                
                let lastDayDislikes = userDislikes.filter {
                    $0.createdTime?.dateValue() ?? defaultDate  > lastDay
                }
                if !lastDayDislikes.isEmpty {
                    self.lastDayEntries.append(lastDayDislikes)
                }
                
                // Last week
                let lastWeekLikes = userLikes.filter {
                    $0.createdTime?.dateValue() ?? defaultDate <= lastDay
                        && $0.createdTime?.dateValue() ?? defaultDate > lastWeek
                }
                if !lastWeekLikes.isEmpty {
                    self.lastWeekEntries.append(lastWeekLikes)
                }
                
                let lastWeekDislikes = userDislikes.filter {
                    $0.createdTime?.dateValue() ?? defaultDate <= lastDay
                        && $0.createdTime?.dateValue() ?? defaultDate > lastWeek
                }
                if !lastWeekDislikes.isEmpty {
                    self.lastWeekEntries.append(lastWeekDislikes)
                }
                
                // Before last week
                let beforeLastWeekLikes = userLikes.filter {
                    $0.createdTime?.dateValue() ?? defaultDate <= lastWeek
                }
                if !beforeLastWeekLikes.isEmpty {
                    self.beforeLastWeekEntries.append(beforeLastWeekLikes)
                }
                
                let beforeLastWeekDislikes = userDislikes.filter {
                    $0.createdTime?.dateValue() ?? defaultDate <= lastWeek
                }
                if !beforeLastWeekDislikes.isEmpty {
                    self.beforeLastWeekEntries.append(beforeLastWeekDislikes)
                }
            }
        }
    }
}
