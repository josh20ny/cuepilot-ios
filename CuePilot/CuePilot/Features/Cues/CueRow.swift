//
//  CueRow.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import SwiftUI

struct CueRow: View {
    let cue: Cue

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    pill(cue.role.rawValue.uppercased())
                    pill(cue.priority.rawValue.uppercased())
                    Text(triggerLabel)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(cue.callText)
                    .font(.body)
                    .lineLimit(4)
            }

            Spacer()

            if cue.checklistFlag {
                Image(systemName: "checklist")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }

    private var triggerLabel: String {
        switch cue.triggerType {
        case .manual:
            return "MANUAL"
        case .relativeStart:
            return "START \(formatOffset(cue.offsetSec))"
        case .relativeEnd:
            return "END \(formatOffset(cue.offsetSec))"
        case .absoluteClock:
            return "CLOCK"
        }
    }

    private func formatOffset(_ seconds: Int?) -> String {
        guard let seconds else { return "" }
        if seconds == 0 { return "+0s" }
        return seconds > 0 ? "+\(seconds)s" : "\(seconds)s"
    }

    private func pill(_ text: String) -> some View {
        Text(text)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
