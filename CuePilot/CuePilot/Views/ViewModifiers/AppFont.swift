//
//  CustomFont.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/22/26.
//

import SwiftUI

struct AppFontStyle: ViewModifier {
    let style: FontStyle
    
    func body(content: Content) -> some View {
        content
            .font(.customFont(style))
    }
}

extension View {
    func appFont(_ style: FontStyle) -> some View {
        modifier(AppFontStyle(style: style))
    }
}
