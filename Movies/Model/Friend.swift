//
//  Friend.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

struct Friend: Identifiable {
    let id, name, imageUrl: String
    let movies: [Movie]
}

let FRIEND_DETAIL = Friend(id: "f1",
                            name: "John",
                            imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-3.jpg",
                            movies: [Movie]())


let FRIENDS = [
    Friend(id: "f1",
           name: "John",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-3.jpg",
           movies: MOVIES),
    Friend(id: "f2",
           name: "Donna",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-7.jpg",
           movies: MOVIES),
    Friend(id: "f3",
           name: "Stephanie",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-5.jpg",
           movies: MOVIES),
    Friend(id: "f4",
           name: "Fred",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-4.jpg",
           movies: MOVIES),
    Friend(id: "f5",
           name: "Zack",
           imageUrl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-6.jpg",
           movies: MOVIES),
]
