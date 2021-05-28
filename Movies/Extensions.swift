//
//  Extensions.swift
//  Movies
//
//  Created by Guillaume Ramey on 17/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 0, cornerRadius: CGFloat = 0) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

extension Collection {
    func mostFrequent() -> Element? where Element: Hashable {
        let counts = reduce(into: [:]) {
            $0[$1, default: 0] += 1
        }
        return counts.max(by: { $0.1 < $1.1 })?.key
    }
}
