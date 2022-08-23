//
//  EnvironmentValues+safeAreaInsets.swift
//  StickyHeader
//
//  Created by Alireza Asadi on 1/6/1401 AP.
//

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets = {
        let insets: UIEdgeInsets = UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene) }
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)?
            .safeAreaInsets ?? .zero


        return EdgeInsets(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
    }()
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        get { self[SafeAreaInsetsKey.self] }
    }
}
