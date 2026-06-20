//
//  CircledPlus.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/19/26.
//

import SwiftUI

struct CircledPlus: View {
    @Environment(\.componentFill) var componentFill
    @Environment(\.componentStroke) var componentStroke
    
    private let padding: CGFloat = 6
    private let circleLineWidth: CGFloat = 2
    private let plusWeight: Font.Weight = .bold
    
    var body: some View {
        GeometryReader { geo in
            let diameter = min(geo.size.width, geo.size.height)
            let plusSize = max(0, diameter - (padding * 2))

            ZStack {
                Circle()
                    .stroke(componentStroke, lineWidth: circleLineWidth)

                Image(systemName: "plus")
                    .font(.system(size: plusSize, weight: plusWeight))
                    .foregroundStyle(componentStroke)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()
        
        CircledPlus()
            .frame(width: 34, height: 34)
            .componentFill(.grey1Translucent)
            .componentStroke(.grey1)
    }
}
