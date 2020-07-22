//
//  Friend.swift
//  Movies
//
//  Created by Guillaume Ramey on 16/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

struct Friend: Identifiable, Equatable {
    var id: UUID
    var name, imageUrl: String
    var movies: [Movie]
}
