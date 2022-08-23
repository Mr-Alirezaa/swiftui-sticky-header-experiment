//
//  View+readingSize.swift
//  StickyHeader
//
//  Created by Alireza Asadi on 1/6/1401 AP.
//

import SwiftUI

private struct SizeReading: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readingSize(onChange action: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizeReading.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizeReading.self, perform: action)
    }
}

