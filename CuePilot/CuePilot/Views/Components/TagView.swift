//
//  TagView.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/7/26.
//

import SwiftUI

struct TagView: View {
    @Environment(\.componentForeground) var componentForeground
    @Environment(\.componentStroke) var componentStroke
    @Environment(\.componentFill) var componentFill
    @Environment(\.componentFrame) var componentFrame
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(componentForeground)
            .font(.customFont(.bodyMonospace))
            .padding(.vertical, .space8)
            .padding(.horizontal, .space24)
            .frame(width: componentFrame.width, height: componentFrame.height)
            .background(
                Capsule()
                    .fill(componentFill)
            )
            .overlay(
                Capsule()
                    .stroke(componentStroke)
            )
    }
}

#Preview {
    let width: CGFloat = 160.0
    
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()
        
        VStack(spacing: .space24) {
            TagView(title: "Producer Action")
                .componentStroke(.grey1)
                .componentFill(.grey1Translucent)
                .componentForeground(.foregroundPrimary)
                .componentFrame(width: width)
            
            TagView(title: "+ Band In-Ears")
                .componentStroke(.blue1)
                .componentFill(.blue1Translucent)
                .componentForeground(.foregroundPrimary)
                .componentFrame(width: width)
            
            TagView(title: "Prod Comms")
                .componentStroke(.green1)
                .componentFill(.green1Translucent)
                .componentForeground(.foregroundPrimary)
                .componentFrame(width: width)
        }
    }
}
