//
//  UserImage.swift
//  Movies
//
//  Created by Guillaume Ramey on 20/05/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct UserImage: View {
    enum Size {
        case small, big
    }
    var image: String
    var size: Size = .small
    
    var body: some View {
        KFImage(URL(string: image))
            .resizable()
            .scaledToFit()
            .frame(width: size == .small ? 50 : 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: size == .small ? 2 : 4))
            .shadow(radius: size == .small ? 2 : 4)
    }
}
