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
        case small, medium, large
        
        var frameWidth: CGFloat {
            switch self {
            case .small: return 50
            case .medium: return 75
            case .large: return 100
            }
        }
        var strokeLineWidth: CGFloat {
            switch self {
            case .small: return 2
            case .medium: return 3
            case .large: return 4
            }
        }
        var radius: CGFloat {
            switch self {
            case .small: return 2
            case .medium: return 3
            case .large: return 4
            }
        }
    }
    var url: URL?
    var image: Image?
    var size: Size = .medium
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
                .frame(width: size.frameWidth)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: size.strokeLineWidth))
                .shadow(radius: size.radius)
        } else {
            KFImage(url)
                .resizable()
                .scaledToFit()
                .frame(width: size.frameWidth)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: size.strokeLineWidth))
                .shadow(radius: size.radius)
        }
    }
}
