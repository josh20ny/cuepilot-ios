//
//  FontStyles.swift
//  CuePilot
//
//  Created by Chris McSorley on 2/22/26.
//

import SwiftUI

enum FontStyle {
    case title
    case body
    case bodyBold
    case bodyMonospace
    case h3Monospace
    case h5Monospace
    
    // TODO: Additional FontStyles
    // Consider: subheadline, caption, captionBold
    
    var fontName: String {
        switch self {
        case .title, .body, .bodyBold: "Inter-VariableFont_opsz,wght"
        case .bodyMonospace, .h3Monospace, .h5Monospace: "FiraMono-Regular"
        }
    }
    
    var pointSize: CGFloat {
        switch self {
        case .title: 16.0
        case .body, .bodyBold: 12.0
        case .bodyMonospace: 12.0
        case .h3Monospace: 24.0
        case .h5Monospace: 15.0
        }
    }
    
    var weight: Font.Weight {
        switch self {
        case .title: .semibold
        case .body, .bodyMonospace, .h3Monospace, .h5Monospace: .regular
        case .bodyBold: .bold
        }
    }
    
    var textStyle: Font.TextStyle {
        switch self {
        case .title: .title
        case .body, .bodyBold, .bodyMonospace: .body
        case .h3Monospace: .title3
        case .h5Monospace: .subheadline
        }
    }
}
