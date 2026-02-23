//
//  Font+Extensions.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/22/26.
//

import SwiftUI

extension Font {
    static func customFont(_ style: FontStyle) -> Font {
        Font.custom(style.fontName, size: style.pointSize, relativeTo: style.textStyle)
            .weight(style.weight)
    }
}
