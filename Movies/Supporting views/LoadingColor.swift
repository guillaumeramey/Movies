//
//  LoadingColor.swift
//  Movie Buddies
//
//  Created by Guillaume Ramey on 01/06/2021.
//  Copyright © 2021 Guillaume Ramey. All rights reserved.
//

import SwiftUI

struct LoadingColor: View {
    @State private var animationAmount: Double = 0
    
    var body: some View {
        Color.primary
            .opacity(0.15 - animationAmount)
            .animation(
                Animation.easeOut(duration: 1)
                    .repeatForever(autoreverses: true)
            )
            .onAppear {
                self.animationAmount = 0.1
            }
    }
}
