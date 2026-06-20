//
//  TagView.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/20/26.
//

import SwiftUI

struct TagView: View {
    let tag: Tag

    init(_ tag: Tag) {
        self.tag = tag
    }

    var body: some View {
        LabeledCapsule(title: tag.rawValue)
            .tagStyle(tag)
            .componentFrame(width: 160.0)
    }
}

private extension LabeledCapsule {
    struct TagViewModifier: ViewModifier {
        let tag: Tag

        func body(content: Content) -> some View {
            switch tag {
                case .bandInEars:
                    content
                        .componentStroke(.blue1)
                        .componentFill(.blue1Translucent)
                        .componentForeground(.foregroundPrimary)

                case .producerAction:
                    content
                        .componentStroke(.grey1)
                        .componentFill(.grey1Translucent)
                        .componentForeground(.foregroundPrimary)

                case .productionComms:
                    content
                        .componentStroke(.green1)
                        .componentFill(.green1Translucent)
                        .componentForeground(.foregroundPrimary)
            }
        }
    }

    func tagStyle(_ tag: Tag) -> some View {
        modifier(TagViewModifier(tag: tag))
    }
}

#Preview {
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()

        VStack(spacing: .space24) {
            TagView(.producerAction)
            TagView(.productionComms)
            TagView(.bandInEars)
        }
    }
}
