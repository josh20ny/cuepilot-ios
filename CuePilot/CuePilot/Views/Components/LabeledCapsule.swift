//
//  TagView.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/7/26.
//

import SwiftUI

struct LabeledCapsule: View {
    @Environment(\.componentFontStyle) private var componentFontStyle
    @Environment(\.componentForeground) private var componentForeground
    @Environment(\.componentStroke) private var componentStroke
    @Environment(\.componentFill) private var componentFill
    @Environment(\.componentFrame) private var componentFrame
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(componentForeground)
            .font(.customFont(componentFontStyle))
            .padding(.vertical, .space8)
            .padding(.horizontal, .space24)
            .frame(width: componentFrame.width, height: componentFrame.height)
            .background(
                Capsule()
                    .fill(componentFill)
            )
            .overlay(
                Capsule()
                    .stroke(componentStroke, lineWidth: 2)
            )
    }
}

#Preview {
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()
        
        VStack(spacing: .space24) {
            LabeledCapsule(title: "LIVE")
                .componentFrame(width: 200)
                .componentFontStyle(.h3Monospace)
                .componentFill(.red1Translucent)
                .componentStroke(.red1)
                .componentForeground(.red1)

            LabeledCapsule(title: "+ Band In-Ears")
                .componentStroke(.blue1)
                .componentFill(.blue1Translucent)
                .componentForeground(.foregroundPrimary)
        }
    }
}
