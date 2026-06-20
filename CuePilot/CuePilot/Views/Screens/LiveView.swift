//
//  MockView.swift
//  CuePilot
//
//  Created by Chris McSorley on 6/19/26.
//

import SwiftUI

struct LiveView: View {
    // MARK: Scaled widths
    @ScaledMetric(relativeTo: FontStyle.h5Monospace.textStyle) private var titleWidth = 100.0
    @ScaledMetric(relativeTo: FontStyle.bodyBold.textStyle) private var cueWidth = 300.0

    // MARK: - Constants
    private let liveCapsuleHeight = 40.0

    // MARK: - Properties
    @State private var viewModel = LiveViewModel()

    private let clockFormatter = WallClockFormatter()
    private let intervalFormatter = TimeIntervalFormatter()

    var body: some View {
        VStack(spacing: .space32) {
            if viewModel.isLive {
                liveCapsule
            } else {
                Spacer()
                    .frame(height: liveCapsuleHeight)
            }

            times
            
            Divider()
                .frame(height: 1.0)
                .overlay(.foregroundPrimary)
                .padding(.horizontal, .space16)

            table
        }
    }

    // MARK: Subviews

    private var liveCapsule: some View {
        LabeledCapsule(title: "LIVE")
            .componentFrame(width: 175, height: liveCapsuleHeight)
            .componentFontStyle(.h3Monospace)
            .componentFill(.red1Translucent)
            .componentStroke(.red1)
            .componentForeground(.red1)
    }

    private var times: some View {
        HStack(spacing: .space64) {
            TimerView(label: "Time", time: .wallClock(viewModel.currentTime))
            TimerView(label: "Time in Current", time: .timer(viewModel.timeInCurrentCue))
            TimerView(label: "Service Time", time: .timer(viewModel.serviceEndOffset))
        }
    }

    private var table: some View {
        Table(viewModel.plan) {
            TableColumn(columnHeader("Title")) { element in
                if let offset = element.timeOffset {
                    Text(intervalFormatter.string(from: offset))
                        .foregroundStyle(Color.foregroundPrimary)
                        .appFont(.h5Monospace)
                        .monospacedDigit()
                }
            }
            .width(titleWidth)

            TableColumn(columnHeader("Cue")) { element in
                Text(element.description)
                    .foregroundStyle(Color.foregroundPrimary)
                    .appFont(.bodyBold)
            }
            .width(cueWidth)

            TableColumn(columnHeader("Tag")) { element in
                TagView(element.tag)
            }
            .width(200.0)

            TableColumn(columnHeader("Notes")) { element in
                if let notes = element.notes {
                    Text(notes)
                        .foregroundStyle(Color.foregroundPrimary)
                        .appFont(.bodyBold)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }

    private func columnHeader(_ title: String) -> Text {
        Text(title)
            .font(.customFont(.title))
            .foregroundStyle(.foregroundPrimary)
    }
}

#Preview {
    ZStack {
        Color.backgroundPrimary
            .ignoresSafeArea()
        
        LiveView()
    }
}
