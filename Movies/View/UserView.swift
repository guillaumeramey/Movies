//
//  UserView.swift
//  Movies
//
//  Created by Guillaume Ramey on 18/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct UserView: View {
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var entryListVM = EntryListViewModel()
    @State private var reaction: UserReaction = .like
    @State private var userName = ""
    @State private var showImagePicker = false
    @State private var userImage: Image?
    @State private var inputImage: UIImage?
    //    @FocusState private var isFocused = false
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                if let user = userVM.user {
                    HStack {
                        UserImage(url: user.imageURL, image: userImage, size: .large)
                            .onTapGesture {
                                showImagePicker.toggle()
                            }
                        
                        TextField("Enter your name", text: $userName, onCommit: {
                            userVM.updateName(newName: userName)
                        })
                        .font(.title2)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .padding(.leading)
                        //                        .focused($isFocused)
                    }
                    .padding()
                } else {
                    SignInWithAppleButton { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        switch result {
                        case .success(let user):
                            print("success")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .frame(height: 45)
                    .padding()
                }
                reactionPicker
                
                if let entries = entryListVM.filteredEntries {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(entries, id: \.self) { entry in
                            MovieCell(movieId: entry.mediaId)
                        }
                    }
                }
            }
            .navigationBarTitle("Profil", displayMode: .inline)
        }
        .onAppear(perform: {
            entryListVM.fetchUserEntries(userVM.user)
            userName = userVM.user?.name ?? ""
        })
        .sheet(isPresented: $showImagePicker, onDismiss: updateImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    var reactionPicker: some View {
        Picker(selection: $reaction, label: Text("Reaction")) {
            ReactionImage(reaction: .like)
                .tag(UserReaction.like)
            ReactionImage(reaction: .dislike)
                .tag(UserReaction.dislike)
            ReactionImage(reaction: .watchlist)
                .tag(UserReaction.watchlist)
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: reaction, perform: { _ in
            entryListVM.filterEntries(with: reaction)
        })
        .onAppear {
            entryListVM.filterEntries(with: reaction)
        }
    }
    
    func updateImage() {
        guard let inputImage = inputImage else { return }
        userImage = Image(uiImage: inputImage)
        userVM.updateImage(image: inputImage)
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        let user = User(name: "Moi",
//                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT80oyYRSnMLUxQaqIewIRloV-7L3ppBNlkng&usqp=CAU")
//        UserView(user: user)
//    }
//}
