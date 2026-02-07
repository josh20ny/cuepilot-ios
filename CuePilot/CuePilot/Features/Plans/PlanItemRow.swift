//
//  PlanItemRow.swift
//  CuePilot
//
//  Created by Joshua Montoya on 2/7/26.
//

import SwiftUI

struct PlanItemRow: View {
    let item: PlanItem

    var body: some View {
        HStack(spacing: 12) {
            Text("\(item.orderIndex + 1)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 28, alignment: .trailing)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)

                HStack(spacing: 8) {
                    Text(item.itemType.rawValue.uppercased())
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(formatDuration(item.plannedDurationSec))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }

    private func formatDuration(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return s == 0 ? "\(m)m" : "\(m)m \(s)s"
    }
}
