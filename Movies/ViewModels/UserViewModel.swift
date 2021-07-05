//
//  UserViewModel.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 03/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UserViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private let storage = Storage.storage()
    @Published var user: User?
    
    func fetchCurrentUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userId).getDocument { documentSnapshot, error in
            if let error = error {
                print("Error fetching current user id: ", userId, "\n", error)
            } else {
                DispatchQueue.main.async {
                    do {
                        self.user = try documentSnapshot?.data(as: User.self)
                    } catch {
                        print("Data error with user id: ", userId, "\n", error)
                    }
                }
            }
        }
    }
    
    func updateName(newName: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userId).updateData(["name": newName]) { error in
            if let error = error {
                print("Error updating name: ", error)
            } else {
                self.user?.name = newName
            }
        }
    }
    
    func updateImage(image: UIImage?) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference().child("users/\(userId).jpg")
        storageRef.putData(imageData, metadata: nil) { storageMetadata, error in
            if let error = error {
                print("Error storing imageData: ", error)
            } else {
                storageRef.downloadURL(completion: { url, error in
                    if let error = error {
                        print("Error getting URL of image: ", error)
                    } else {
                        self.updateImagePath(url: url)
                    }
                })
            }
        }
    }
    
    private func updateImagePath(url: URL?) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userId).updateData(["imagePath": url?.absoluteString ?? ""]) { error in
            if let error = error {
                print("Error updating imagePath: ", error)
            } else {
                self.user?.imagePath = url?.absoluteString
            }
        }
    }
}
