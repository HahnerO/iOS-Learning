//
//  Modifier.swift
//  GayhubSwiftify
//
//  Created by 王籽涵 on 2020/8/21.
//  Copyright © 2020 hahn. All rights reserved.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}
