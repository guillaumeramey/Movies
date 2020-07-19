//
//  Friend.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

struct Friend: Identifiable {
    var id: UUID
    var name, imageUrl: String
    var movies: [Movie]
}

let FRIENDS = [
    Friend(id: UUID(),
           name: "John",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-3.jpg",
           movies: MOVIES),
    Friend(id: UUID(),
           name: "Donna",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-7.jpg",
           movies: MOVIES),
    Friend(id: UUID(),
           name: "Stephanie",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-5.jpg",
           movies: MOVIES),
    Friend(id: UUID(),
           name: "Fred",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-4.jpg",
           movies: MOVIES),
    Friend(id: UUID(),
           name: "Zack",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-6.jpg",
           movies: MOVIES),
]
